import csv, smtplib, ssl

from datetime import date


today = date.today().strftime('%B %d, %Y')


message = '''Subject: Your evaluation


Hi {name}, the date of your Q1 evaluation is {date}. Your score is: {score}'''

from_address = 'YOUR EMAIL ADDRESS'

# You may need to create an app password for Gmail here: https://myaccount.google.com/apppasswords

password = input('Enter password: ')


context = ssl.create_default_context()

with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as server:

    server.login(from_address, password)

    # use a customers.csv file with name, email, and score columns

    with open('customers.csv') as file:

        reader = csv.reader(file)

        for name, email, score in reader:

            server.sendmail(

                from_address,

                email,

                message.format(name=name,date=today, score=score),

            )
