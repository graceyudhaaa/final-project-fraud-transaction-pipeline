from confluent_kafka.avro import AvroConsumer
from google.cloud import bigquery
import os 
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

from dotenv import load_dotenv

load_dotenv()

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = os.path.abspath(os.path.join(os.path.dirname( __file__ ), '..', 'service-account', 'service-account.json'))

dataset_name = 'onlinetransaction_stream'
fraud_table_name = 'fraud_detection'
payment_table_name = 'payment'

client = bigquery.Client()
dataset_ref = client.dataset(dataset_name)
dataset = bigquery.Dataset(dataset_ref)

# Define the schema for both tables
schema = [
    bigquery.SchemaField('step', 'INT64'),
    bigquery.SchemaField('type', 'STRING'),
    bigquery.SchemaField('amount', 'FLOAT64'),
    bigquery.SchemaField('nameOrig', 'STRING'),
    bigquery.SchemaField('oldbalanceOrg', 'FLOAT64'),
    bigquery.SchemaField('newbalanceOrig', 'FLOAT64'),
    bigquery.SchemaField('nameDest', 'STRING'),
    bigquery.SchemaField('oldbalanceDest', 'FLOAT64'),
    bigquery.SchemaField('newbalanceDest', 'FLOAT64'),
    bigquery.SchemaField('isFraud', 'INT64'),
    bigquery.SchemaField('isFlaggedFraud', 'INT64')
]

#  referensi tabel yang fraud
fraud_table_ref = dataset.table(fraud_table_name)
fraud_table = bigquery.Table(fraud_table_ref, schema=schema)
client.create_table(fraud_table, exists_ok=True)
#  referensi tabel yang tidak fraud
payment_table_ref = dataset.table(payment_table_name)
payment_table = bigquery.Table(payment_table_ref, schema=schema)
client.create_table(payment_table, exists_ok=True)

# Fungsi untuk mengirim email
def send_email(subject, body):
    sender_email = os.environ["SENDER_EMAIL"]  # Ganti dengan alamat email pengirim
    receiver_email = os.environ["RECEIVER_EMAIL"]  # Ganti dengan alamat email penerima
    password = os.environ["SENDER_PASSWORD"]  # Ganti dengan password email pengirim

    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject

    message.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(sender_email, password)
        server.sendmail(sender_email, receiver_email, message.as_string())
        print("Email sent successfully")
    except Exception as e:
        print(f"Failed to send email: {e}")
        raise  # Tambahkan raise untuk mencetak traceback dari error
    finally:
        server.quit()

def read_messages():
    consumer_config = {"bootstrap.servers": "localhost:9092",
                       "schema.registry.url": "http://localhost:8082",
                       "group.id": "online_payment.avro.consumer.2",
                       "auto.offset.reset": "earliest"}

    consumer = AvroConsumer(consumer_config)
    consumer.subscribe(["online_payment"])

    while True:
        try:
            message = consumer.poll(5)
        except Exception as e:
            print(f"Exception while trying to poll messages - {e}")
        else:
            if message is not None:
                print(f"Successfully poll a record from "
                      f"Kafka topic: {message.topic()}, partition: {message.partition()}, offset: {message.offset()}\n"
                      f"message key: {message.key()} || message value: {message.value()}")
                consumer.commit()

                # Always insert into the online_payment table
                table = bigquery.Table(payment_table_ref, schema=schema)
                client.insert_rows_json(table, [message.value()])

                # Check if isFraud = 1, then also insert into detected_fraud table
                is_fraud = message.value().get('isFraud')
                if is_fraud == 1:
                    table = bigquery.Table(fraud_table_ref, schema=schema)
                    client.insert_rows_json(table, [message.value()])
                    send_email("Fraud Alert", "Data with payment fraud detected and entered into the fraud_detection table!")
            else:
                print("No new messages at this point. Try again later.")

    consumer.close()


if __name__ == "__main__":
    read_messages()
