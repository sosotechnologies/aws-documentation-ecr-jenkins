# Flask Lecture
App that does the following:
- Accept user info
- Retrieve info from a MySQL Database
- Create, Read, Update, Delete (CRUD) Info from the MySQL Database
- Return Info to user as requested

***Architecture***
- FrontEnd: HTML/CSS, Bootstrap, JS, JQuery...
- Flask Web Application
- SQL Database (Database SQLite)
- WTForms
- Jinja Templates

## Install Anaconda
Installation Link: [Install for Windows](https://www.anaconda.com/download)
Be sure to Add to path in step 8: [Installation doc for windows](https://docs.anaconda.com/free/anaconda/install/windows/)

***Create virtual environment***

```
conda create -n sosoflaskenv python=3.6
[To delete] --> His was conda create -n mynewflaskenv python=3.6

activate sosoflaskenv
pip install requirements.txt
``` 

## Getting Started
### HTML
#### Sample html template
test.html

```html
<!DOCTYPE html>
<html>

<head>
    <title>Soso Technologies HTML Page</title>
</head>

<body>
    <h1>Welcome to Soso Technologies HTML Page</h1>
    <p>This is a simple HTML template.</p>
    <p>You can add your content here.</p>
</body>

</html>
```

#### List
- Adding the 3 different types of list in html
test.html

```html
<!DOCTYPE html>
<html>

<head>
    <title>Soso Technologies HTML Page</title>
</head>

<body>
    <h1>Welcome to Soso Technologies HTML Page</h1>
    <p>This is a simple HTML template.</p>
    <p>You can add your content here.</p>

    <ul>
      <li>Kubernetes</li>
      <li>Docker</li>
      <li>Terraform</li>
    </ul>

    <ol>
      <li>Kubernetes</li>
      <li>Docker</li>
      <li>Terraform</li>
    </ol>

    <dl>
      <dt>Python</dt>
      <dd>- Study python</dd>
      <dt>AI</dt>
      <dd>- Study AI</dd>
    </dl>
    
</body>

</html>
```

#### Dif and spans
- A <div> section in a document that is styled with CSS
- For dif, The belowdiv will call a css and apply styling within the div tags

```html
<!DOCTYPE html>
<html>
<head>
<style>
.sosoDiv {
  border: 5px outset red;
  background-color: lightblue;    
  text-align: center;
}
</style>
</head>
<body>

    <h1>Welcome to Soso Technologies HTML Page</h1>
    
<div class="sosoDiv">
  <p>This is a simple HTML template.</p>
  <p>You can add your content here.</p>
  <p>This is some text in a div element.</p>
</div>

<p>This is some text outside the div element.</p>

</body>
</html>
```

***Span***

- A <span> element which is used to color a part of a text:
- For ***spam***, The below spam element which is used to color a part of a text

```html
<!DOCTYPE html>
<html>
<head>
<style>
.sosoDiv {
  border: 5px outset red;
  background-color: lightblue;    
  text-align: center;
}
</style>
</head>
<body>

    <h1>Welcome to Soso Technologies HTML Page</h1>
    
<div class="sosoDiv">
  <p>This is a simple HTML template.</p>
  <p>You can add your content here.</p>
  <p>This is some text in a div element.</p>
</div>

<p>Sosotech logo is <span style="color:rgb(5, 232, 39);font-weight:bold">green</span> for nature.</p>

</body>
</html>
```
#### Attributes
- HTML attributes provide additional information about HTML elements.
- Just adding a link as an attribute
- also added an image inside folder called photos and pic is named: sosotechlogo.jpg

```html
<!DOCTYPE html>
<html>
<head>
<style>
.sosoDiv {
  border: 5px outset red;
  background-color: lightblue;    
  text-align: center;
}
</style>
</head>
<body>

    <h1>Welcome to Soso Technologies HTML Page</h1>
    

<div class="sosoDiv">
  <p>This is a simple HTML template.</p>
  <p>You can add your content here.</p>
  <p>This is some text in a div element.</p>
</div>

<a href="https://www.sosotechnologies.com">Visit sosotech</a>

<img src="images/sosotechlogo.jpg" title="Official Logo" alt="We Know Technology!"/>

</body>
</html>
```

#### Form and label
- We have the ***GET*** and ***POST*** values for label
- adding a basic form with each label corresponding to the input
- also added a break element as seen <br>
- the action will point to a specific file, that we have the form details

```html
<!DOCTYPE html>
<html>
<head>
<style>
.sosoDiv {
  border: 5px outset red;
  background-color: lightblue;    
  text-align: center;
}
</style>
</head>
<body>

    <h1>Welcome to Soso Technologies HTML Page</h1>
    <br> 
<form action="#" method="post" class="sosoDiv">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required><br><br>
        
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="" required><br><br>
        
    <label for="message">Message:</label><br>
    <textarea id="message" name="message" rows="5" cols="30" required></textarea><br><br>
        
  <input type="submit" value="Submit">
</form>

<a href="https://www.sosotechnologies.com">Visit sosotech</a>

<img src="images/sosotechlogo.jpg" title="Official Logo" alt="We Know Technology!"/>

</body>
</html>
```

***Another basig Form***
- I added a placeholder for password and email in the boxes
- Also add an action in the form
- Also add a radio, for yes or no Option

```html
<!DOCTYPE html>
<html>
<head>
<style>
.sosoDiv {
  background-color: lightblue;    
  text-align: center;
}
</style>
</head>
<body>

    <h1>Welcome to Soso Technologies HTML Page</h1>
    <br> 
<form action="#" method="get" class="sosoDiv">
        
    <label for="email">Email:</label>
    <input type="email" id="email" name="sosousersemail" placeholder="enter your email" required><br><br>

    <label for="password">Password:</label>
    <input type="password" name="sosouserspassword" placeholder="password" required><br><br>
        
    <label for="option">Do you like SoSoTechnologies?</label><br>
    <input type="radio" id="yes" name="option" value="yes">
    <label for="yes">Yes</label>
    <input type="radio" id="no" name="option" value="no">
    <label for="no">No</label><br><br>
    
    <input type="Submit" name="" value="Submit"><br><br>
        
</form>

<a href="https://www.sosotechnologies.com">Visit sosotech</a>

<img src="images/sosotechlogo.jpg" title="Official Logo" alt="We Know Technology!"/>

</body>
</html>
```

### CSS
- Create a ***.css*** file 
- Connect CSS to HTML

#### Designing the Heading in a separate css file
- Create a ***.css*** file called css-link.css
- create a new HTML file called html-link.html
- Connect CSS to HTML

This is the ***css-link.css*** file that will be used for the below html file.

```css
h1 {
  color: red;
}
```

This is the ***html-link.html*** file that will be used connect with the above .css file.

```html
<!DOCTYPE html>
<html>
<head>
    <title>HTML Link</title>
    <link rel="stylesheet" href="css-link.css">
</head>
<body>
    <h1>Welcome to SosoTechnologies</h1>
</body>
</html>
```

#### Add an <li> element to css and html files

```html
<!DOCTYPE html>
<html>
<head>
    <title>HTML Link</title>
    <link rel="stylesheet" href="css-link.css">
</head>
<body>
    <h1>Welcome to SosoTechnologies</h1>

    <ul>
        <li>Python</li>
        <li>Kubernetes</li>
    </ul>
</body>
</html>
```

```css
h1 {
  color: red;
}

li {
  color: blue;
}
```

#### Add hex color

```html
<!DOCTYPE html>
<html>
<head>
    <title>HTML Link</title>
    <link rel="stylesheet" href="css-link.css">
</head>
<body>
    <h1>Welcome to SosoTechnologies</h1>

    <h3>This is Soso hex color</h3>

    <ul>
        <li>Python</li>
        <li>Kubernetes</li>
    </ul>

    <p>Add my soso paragraph.</p>

</body>
</html>
```

```css
h1 {
  color: red;
}

li {
  color: blue;
}

p {
  color:rgb(43, 90, 20);
}

/* These are [hex color], you can google this */
h3 {
  color: #0e5922;
}
```

***Adding SPAN to a paragraph and updating the CSS file to reflect div***

```html
<!DOCTYPE html>
<html>
<head>
    <title>HTML Link</title>
    <link rel="stylesheet" href="css-link.css">
</head>
<body>
    <h1>Welcome to SosoTechnologies</h1>

    <h3>This is Soso hex color</h3>

    <ul>
        <li>Python</li>
        <li>Kubernetes</li>
    </ul>

    <p>My soso paragraph is outside the div.</p>
    <div>
        <p>My New soso paragraph is inside the div.</p>
        <p>Add a span inside the div...<span>THIS IS A SPAN</span></p>
    </div>

</body>
</html>
```

```css
div{
    border: 5px outset red;
    background-color: lightblue;    
    text-align: center;
    border-width: 10px;
    border-style: solid;
}
```

***Adding multiple SPAN paragraph and updating the CSS file to reflect different div***

```html
<!DOCTYPE html>
<html>
<head>
    <title>HTML Link</title>
    <link rel="stylesheet" href="css-link.css">
</head>
<body>
    <h1>Welcome to SosoTechnologies</h1>

    <h3>This is Soso hex color</h3>

    <ul>
        <li>Python</li>
        <li>Kubernetes</li>
    </ul>

    <p>My soso paragraph is outside the div.</p>
    <div class="firstsosoDiv">
        <p>My New soso paragraph is inside the div.</p>
        <p>Add a span inside the div...<span>THIS IS A FIRST SPAN</span></p>
    </div>

    <div class="secondsosoDiv">
        <p>My New soso paragraph is inside the div.</p>
        <p>Add a span inside the div...<span>THIS IS A SECOND SPAN</span></p>
    </div>

</body>
</html>
```

```css
.firstsosoDiv{
  border: 5px outset red;
  background-color: lightblue;    
  text-align: center;
  border-width: 10px;
  border-style: solid;
}

.secondsosoDiv{
  border: 5px outset rgb(0, 30, 255);
  background-color: rgb(219, 211, 191);    
  text-align: center;
  border-width: 10px;
  border-style: solid;
}
```

### BootStrap

Checkout this website: [For BootStrap examples](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
Checkout this navBars: [For BootStrap navBar examples](https://getbootstrap.com/docs/5.3/components/navbar/
## FLASK

### Create Virtual Environments
Virtual environments are isolated environments that allow you to manage and isolate dependencies, packages, and Python versions for different projects. Navigate to the directory where you want to create your virtual environment.
Run the command: 

with conda, install an env called myflaskenv, alongside flask

```
conda create -n myflaskenv flask
activate myflaskenv 
[OR]
source activate myflaskenv   (for Linux machines)
```

- To deactivate environment

```
deactivate
[OR]
source deactivate (for Linux machines)
```

#### Flask application for a single page

```py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, SosoWorld!'

if __name__ == '__main__':
    app.run()
```

#### Flask application routing of page
- add an app route called register to url
- so I can now open as http://127.0.0.1:5000/register

```py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/register')
def register():
    return '<h1>Registration page</>'

if __name__ == '__main__':
    app.run()
```

#### Dynamic variable - add debug
- definine the course and apply a variable name, which can be defined to any course of your choice.
EXample:
- http://127.0.0.1:5000/course/kubernetes
- http://127.0.0.1:5000/course/docker

```py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, World!'

@app.route('/register')
def register():
    return '<h1>Registration page</>'

#This section is a dynamic defination
@app.route('/course/<name>')
def course(name):
    return '<h1>Select your course of study from this page: {}<h1>'.format(name)
#dynamic defination section ends

if __name__ == '__main__':
    app.run(debug=True)
```

### Flask Templates
In Flask, a template is an HTML file that contains placeholders for dynamic content. Templates allow you to separate the presentation logic (HTML markup) from the application logic (Python code). This follows the principle of separation of concerns.

Flask uses a templating engine called Jinja2, which provides a powerful and flexible way to generate dynamic HTML content. With templates, you can easily insert variables, perform conditional logic, iterate over lists, and more.

To use templates in Flask, you need to create a templates directory in your project and place your HTML template files inside it. Here's an example of a simple Flask template

#### Soso-Templates
- Create a register.html file in the template folder
- Update the app.py file to add a render template
- Create a static file inside this folder

Here is the folder tree
.
|-- Soso-Templates
|   |-- 01-app.py
|   |-- static
|   |   `-- sosotech.jpg
|   `-- templates
|       |-- 01-Template.html

##### 01-Templete
Create 
- name the htmp file: ***01-Template.html***
- name the py file: ***01-app.py***

```html
<<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Basic</title>
  </head>
  <body>
    <h1>Hello SosoNation!</h1>
    <h3>Here is our sample CICD Architecture Diagram!</h3>
    <img src="../static/sosotech.jpg" width="600" height="400">

  </body>
</html>
```

```py
from flask import Flask, render_template
app = Flask(__name__)


@app.route('/')
def index():
    # Connecting to a template (html file)
    return render_template('01-Template.html')

if __name__ == '__main__':
    app.run(debug=True)
```

##### 02-Connecting flask to Templete - Variables
Create 
- name the htmp file: ***02-Template.html***
- name the py file: ***02-app.py***
- Modify boty files from 01-Template, also adding indexing of the name
- Check out the localhost links:
  - http://127.0.0.1:5000
  - http://127.0.0.1:5000/sosocourse/kubernetes


```py
from flask import Flask, render_template
app = Flask(__name__)


@app.route('/')
def index():

    return '<h1> Chcekout our list of /course/name </h1>'

@app.route('/course/<name>')
def course_name(name):

    return render_template('02-Template.html',name=name)

@app.route('/sosocourse/<name>')
def soso_course_name(name):
    letters = list(name)
    course_list = {'course_name':name}
    return render_template('02-Template.html',
                           name=name,sosocourselist=letters,ourcollection=course_list)


if __name__ == '__main__':
    app.run(debug=True)
```

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Basic</title>
  </head>
  <body>
    <h1>Basic variable insert: {{name}}!</h1>
    <h1>List example: {{mylist}}</h1>
    <h1>Indexing the list for the first letter: {{sosocourselist[0]}}</h1>
    <h1>course name from dictionary: {{ourcollection['course_name']}}</h1>
  </body>
</html>
```

##### 03-Templete - adding links to the html file
- name the htmp file: ***03-Template.html***
- name the py file: ***03-app.py***
- Add a link to the photo in static
- Open in url: http://127.0.0.1:5000/static/sosotech.jpg

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Basic</title>
  </head>
  <body>
    <h1>Basic variable insert: {{ name }}!</h1>
    <h1>List example: {{ mylist }}</h1>
    <h1>Indexing the list for the first letter: {{ sosocourselist[0] }}</h1>
    <h1>Course name from dictionary: {{ ourcollection['course_name'] }}</h1>
    <img src="{{ url_for('static', filename='sosotech.jpg') }}" alt="SosoTech Image" width="600" height="400">
  </body>
</html>
```

```py
from flask import Flask, render_template
app = Flask(__name__)


@app.route('/')
def index():

    return '<h1> Chcekout our list of /course/name </h1>'

@app.route('/course/<name>')
def course_name(name):

    return render_template('02-Template.html',name=name)

@app.route('/sosocourse/<name>')
def soso_course_name(name):
    letters = list(name)
    course_list = {'course_name':name}
    return render_template('02-Template.html',
                           name=name,sosocourselist=letters,ourcollection=course_list)


if __name__ == '__main__':
    app.run(debug=True)
```

##### 04-Forms - Connect HTML forms to flask application
Create the following files:
- name the py file: ***04-app.py***
- name the htmp file: ***04-1-Template-welcome.html***
- name the htmp file: ***04-2-Template-thanks.html***
- name the htmp file: ***04-3-Template-index.html***
- name the htmp file: ***04-4-Template-404.html***
- name the htmp file: ***04-5-Template-basic.html***
- Check sites:
  - http://127.0.0.1:5000/sososignup_form
  - http://127.0.0.1:5000/ftetsjjsj  --> to test 404 error message

***04-app.py***

```py
from flask import Flask, render_template, request
app = Flask(__name__)

@app.route('/')
def index():
    return render_template('04-3-Template-index.html')

@app.route('/sososignup_form')
def sososignup_form():
    return render_template('04-1-Template-welcome.html')

@app.route('/thanks')
def thanks():
    first = request.args.get('first')
    last = request.args.get('last')
    return render_template('04-2-Template-thanks.html',first=first,last=last)

@app.errorhandler(404)
def page_is_broken(e):
    return render_template('04-4-Template-404.html'), 404


if __name__ == '__main__':
    app.run(debug=True)
```

***04-1-Template-welcome.html***

```html
{% extends "04-5-Template-basic.html"%}
{% block content %}
<div class="jumbotron">


<h1>Welcome to the sign up Form!</h1>
<h3>Register for the course of choice!</h3>
<p>Please fill out the form below to register.</p>
    <form action="{{url_for('thanks')}}">
       <label for="first">First Name</label>
        <input type="text" name="first" required><br>
        <label for="last">Last Name</label>
        <input type="text" name="last" required><br>
        <input type="submit" value="Submit Form">
    </form>

</div>
{% endblock %}
```

***04-2-Template-thanks.html***

```html
{% extends "04-5-Template-basic.html"%}
{% block content %}
<div class="jumbotron">

  <h1>Thank you for signing up for our course {{first}} {{last}}!</h1>
</div>
{% endblock %}
```

***04-3-Template-index.html***

```html
{% extends "04-5-Template-basic.html"%}
{% block content %}
<div class="jumbotron">
<p>Welcome to Sosotechnologies!</p>
<p>Wanna sign up for our Courses</p>
<a href="{{url_for('sososignup_form')}}">Sign up for our courses here</a>
</div>
{% endblock %}
```

***04-4-Template-404.html***

```html
{% extends "04-5-Template-basic.html"%}
{% block content %}
<div class="jumbotron">
<p>Sorry, this SoSo Page is not soso at this time.</p>
<p>Please check-back later!</p>
</div>
{% endblock %}
```

***04-5-Template-basic.html***

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>SoSoTech</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.3/css/bootstrap.min.css" integrity="sha384-pzjw8Gi+dFwwSAw9+0Bt9o/xkJXhsv/N9nEV+IBkTJkzE4vDlSLF/xjiVSWX8ZW9" crossorigin="anonymous">
    <img src="{{ url_for('static', filename='sosotech.jpg') }}" alt="SosoTech Image" width="600" height="400">
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="{{url_for('index')}}">SosoTech Home Page</a>
    </nav>
    {% block content %}
    {% endblock %}
  </body>
</html>
```

### soso-Forms

#### 02 Flask Form Example
Create the following files
- templates
  - 02-form-thanks.html
  - 02-form.html
- 02-Form.py

***02-form-thanks.html***

```html
<h1>Thank you for your submission!</h1>
<ul>
  <li>Study Courses: {{ session['studycourses'] }}</li>
  <li>DevOps Experience: {{ session['neutered'] }}</li>
  <li>Course Feedback: {{ session['thought'] }}</li>
  <li>Favorite Course: {{ session['course'] }}</li>
  <li>Additional Feedback: {{ session['feedback'] }}</li>
</ul>
```

***02-form.html***

```html
<h1>Welcome to Study Course Surveys</h1>
<form method="POST">
    {# This hidden_tag is a CSRF security feature. #}
    {{ form.hidden_tag() }}
    {{ form.studycourses.label }} {{ form.studycourses }}
    <br>
    {{ form.neutered.label }} {{ form.neutered }}
    <br>
    {{ form.course.label }} {{ form.course }}
    <br>
    {{ form.thought.label }} {{ form.thought }}
    <br>
    Any other feedback?
    <br>
    {{ form.feedback }}
    <br>
    {{ form.submit() }}
</form>
```

***02-Form.py***

```py
from flask import Flask, render_template, session, redirect, url_for
from flask_wtf import FlaskForm
from wtforms import StringField, BooleanField, RadioField, SelectField, TextAreaField, SubmitField
from wtforms.validators import DataRequired

app = Flask(__name__)
app.config['SECRET_KEY'] = 'sososecretkey'

class CourseInfoForm(FlaskForm):
    studycourses = StringField('What study courses are you interested in?', validators=[DataRequired()])
    neutered = BooleanField("Do you have any DevOps Experience?")
    thought = RadioField('What do you think of our course List:', choices=[('thought_one', 'SOSO'), ('thought_two', 'Excited')])
    course = SelectField(u'Pick Your Favorite Course:', choices=[('k8s', 'Kubernetes'), ('dc', 'Docker'), ('Ter', 'Terraform'), ('Cloud', 'AWS')])
    feedback = TextAreaField()
    submit = SubmitField('Submit')

@app.route('/', methods=['GET', 'POST'])
def index():
    form = CourseInfoForm()
    if form.validate_on_submit():
        session['studycourses'] = form.studycourses.data
        session['neutered'] = form.neutered.data
        session['thought'] = form.thought.data
        session['course'] = form.course.data
        session['feedback'] = form.feedback.data
        return redirect(url_for("thanks"))
    return render_template('02-form.html', form=form)

@app.route('/thanks')
def thanks():
    return render_template('02-form-thanks.html')

if __name__ == '__main__':
    app.run(debug=True)
```

### Databases - SQLite
In this code, SQLAlchemy is used for database operations. The ***Survey*** class is defined as a SQLAlchemy model representing the survey table. The SQLALCHEMY_DATABASE_URI configuration is set to your MySQL database URI.
Ensure you replace 'your_username', 'your_password', and 'your_database' in the SQLALCHEMY_DATABASE_URI with your actual MySQL database credentials.
Make sure you have the necessary dependencies installed, including flask_sqlalchemy.

```
pip install Flask-SQLAlchemy
```

#### SQLite









***Common commands***

```
quit()
pip3 show Flask-WTF
```

NOTE TO SELF
- skipped lesson 4 install Atom


https://www.udemy.com/course/python-and-flask-bootcamp-create-websites-using-flask/learn/lecture/10533502#overview


I will be teaching the following subjects
- Devops
- GitOps
- CICD
- Ansible
- AWS
- Jenkins
- Docker
- Kubernetes
- Flask

Write an introductory message to share with my audience

