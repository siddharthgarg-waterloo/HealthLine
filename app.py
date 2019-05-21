from flask import Flask, request
from twilio.twiml.messaging_response import Body, Message, Redirect, MessagingResponse
from twilio.rest import Client

# scraper
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time
from bs4 import BeautifulSoup

account_sid = 'AC5f0e1ef942cafede8b103520d0685a6d'
auth_token = 'e8d7f9e9f8e107f20d0e18853d932ffa'
client = Client(account_sid, auth_token)


# gender, age are strings. symptoms is a list of strings
def scrapeMed(gender, age, symptoms):   
    driver = webdriver.Chrome()
    driver.get("https://symptoms.webmd.com/default.htm#/info")
    time.sleep(3)
    popupBox = driver.find_element_by_xpath("//*[@id='webmdHoverClose']")
    popupBox.click()
    time.sleep(2)
    ageBox = driver.find_element_by_xpath("//*[@id='age']")
    ageBox.send_keys(age)
    if gender == 'm':
        genderButton = driver.find_element_by_xpath("//*[@id='male']")
        genderButton.click()
    else:
        genderButton = driver.find_element_by_xpath("//*[@id='female']")
        genderButton.click()


    continueButton = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div/div/div/div[2]/button")
    continueButton.click()
    mainSymptomBox = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div/div[1]/div[1]/typeahead/div/form/input")
    mainSymptomBox.send_keys(symptoms[0])
    time.sleep(3)
    mainSymptomBox.send_keys(Keys.ARROW_DOWN)
    mainSymptomBox.send_keys(Keys.ENTER)
    time.sleep(1)
    try:
        skip = driver.find_element_by_xpath("//*[@id='webmdHoverLoadedContent']/div/div/button[1]/div")
        skip.click()
    except:
        pass

    for symptom in symptoms[1:]:
        addSymptomBox = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div/div[1]/div[1]/typeahead/div/form/input")
        addSymptomBox.send_keys(symptom)
        time.sleep(2)
        addSymptomBox.send_keys(Keys.ARROW_DOWN)
        addSymptomBox.send_keys(Keys.ENTER)
        try:
            skip = driver.find_element_by_xpath("//*[@id='webmdHoverLoadedContent']/div/div/button[1]/div")
            skip.click()
        except:
            pass
        time.sleep(1)

    continueAgain = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div/div[2]/button[2]")
    continueAgain.click()
    skipLink = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div/div[1]/div[1]/div/a")
    skipLink.click()

    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')
    conditions = soup.find_all("div", class_="capitalize inline-block")
    condition_1 = conditions[0].get_text()
    condition_2 = conditions[1].get_text()
    condition_3 = conditions[2].get_text()
    time.sleep(1)
    symptomClick = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div/div[2]/div[1]/div/possible-conditions/div/ul/li[1]/div[1]")
    symptomClick.click()
    time.sleep(2)
    treatmentClick = driver.find_element_by_xpath("//*[@id='symptom-checker']/div[2]/div/div[1]/div[1]/div[2]/div[2]/div[2]/ul/li[2]/a")
    treatmentClick.click()
    html = driver.page_source
    soup = BeautifulSoup(html, 'html.parser')
    treatment_1 = soup.find('div', {'ng-bind-html':"vm.treatmentDesc"}).find('p').get_text()

    driver.close()

    print("This is your HealthLine Diagnosis based on the following information:\nGender: {}\nAge: {}\nSymptoms: {}\nThe condition that matches your symptoms the most is the {}. \nOther Conditions that are less likely are the {} as well as the {}.\n{}".format(gender, age, ", ".join(symptoms), condition_1, condition_2, condition_3, treatment_1))
    return("This is your HealthLine Diagnosis based on the following information:\nGender: {}\nAge: {}\nSymptoms: {}\nThe condition that matches your symptoms the most is the {}. \nOther Conditions that are less likely are the {} as well as the {}.\n{}".format(gender, age, ", ".join(symptoms), condition_1, condition_2, condition_3, treatment_1))


app = Flask(__name__)

@app.route("/sms", methods=['GET', 'POST'])
def sms_ahoy_reply():
    """Respond to incoming messages with a friendly SMS."""
    # Start our response
    body = request.form['Body']
    resp = MessagingResponse()

    msg = body.split(' ')

    print(msg)
    
    send = scrapeMed(msg[1], msg[2], msg[3:])

    message = client.messages.create(body=send, from_='+15063062122', to=msg[0])

    # Add a message
    resp.message("sent")

    return str(resp)

if __name__ == "__main__":
    
    app.run(debug=True)


