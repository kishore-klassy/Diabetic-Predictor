from flask import Flask, request, jsonify
import logging
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix

app = Flask(__name__)

def predictDiabetes(Pregnancies, Glucose, BloodPressure, SkinThickness, Insulin, BMI, DiabetesPedigreeFunction, Age) :
    # load the dataset
    url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv"
    names = ['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness', 'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age', 'Outcome']
    data = pd.read_csv(url, names=names)

    X = data.iloc[:, :-1].values
    y = data.iloc[:, -1].values

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = LogisticRegression()

    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)

    data = np.array([[Pregnancies, Glucose, BloodPressure, SkinThickness, Insulin, BMI, DiabetesPedigreeFunction, Age]])
    prediction = model.predict(data)
    if prediction[0] == 0:
        return "Non-diabetic"
    else:
        return "Diabetic"



@app.route('/',methods=['POST','GET'])
def diabeticPredictor():
    data = request.get_json()
    BMI = data.get('BMI')
    Pregnancies = data.get('Pregnancies')
    Glucose= data.get('Glucose')
    BloodPressure = data.get('BloodPressure')
    Insulin = data.get('Insulin')
    SkinThickness = data.get('SkinThickness')
    DiabetesPedigreeFunction = data.get('DiabetesPedigreeFunction')
    Age = data.get('Age')

    result = predictDiabetes(Pregnancies, Glucose, BloodPressure, SkinThickness, Insulin, BMI, DiabetesPedigreeFunction, Age)
    return jsonify(result=result)


if __name__ == "__main__":
    app.run(debug=True)












