###*
 Helpers
###

j$ =
	element: (selector) ->
		$(selector)
	input: (name) ->
		$("input[name='#{name}']")


###*
App Page
###
AppPage = () ->
	@get = ->
		browser.get '/'

###*
 Login Page
###
LoginPage = () ->
	@get = ->
		browser.get browser.params.baseUrl + '/#/login'
	@login = (u, p) ->
		j$.input('username').sendKeys('test@gmail.com')
		j$.input('password').sendKeys('test')
		j$.element('button[type="submit"]').click()


###*
 Register Page
###
RegisterPage = () ->
	email = j$.input('email')
	username = j$.input('username')
	password = j$.input('password')
	password2 = j$.input('password2')
	agree = j$.input('agree')
	@get = ->
    browser.get '/#/register'
	@register = ->
		email.sendKeys('test@email.com')
		username.sendKeys('test')
		password.sendKeys('test')
		password2.sendKeys('test')
		agree.click()
		element(protractor.By.css('button[type="submit"]')).click()


#
# App.coffee
#
# This is the protractor spec that will test the different areas of the application.
#
UsersPage = ->
  @newUserBtn = element(protractor.By.buttonText("New User"))
  @submitBtn = element(protractor.By.buttonText("Submit"))
  @inputs =
    email: element(protractor.By.model("user.email"))
    username: element(protractor.By.model("user.username"))
    password: element(protractor.By.model("user.password"))
    name: element(protractor.By.model("user.meta.name"))
    summary: element(protractor.By.model("user.meta.summary"))

  @get = ->
    browser.get '/#/users'

  @setForm = (email, username, password, name, summary) ->
    @newUserBtn.click()
    browser.sleep 500
    @inputs.username.sendKeys username
    @inputs.email.sendKeys email
    @inputs.password.sendKeys password
    @inputs.name.sendKeys name
    @inputs.summary.sendKeys summary
    @submitBtn.click()
    browser.sleep 1000


###*
Protractor e2e Tests
###
describe "Angular-CMS App", ->
  App = new AppPage()
  registerPage = new RegisterPage()
  loginPage = new LoginPage()

	beforeEach ->
		App.get()

	#Welome Story: the initial page
	describe 'Index:', ->
		it "should display the main index view as default", ->
			expect(driver.getCurrentUrl()).toEqual '/'

		it 'should have a .navbar-brand on the page', ->
			expect(j$.element('.navbar-brand', 'Site title').count()).toEqual 1

		it 'should have a .login-btn element with a link to the login page', ->
			expect(j$.element('a[href="#/login"]', 'the Login link').count()).toEqual 1

		it 'should have a .media element for a feature', ->
			browser.sleep 1
			expect(j$.element('.media').count()).toBeGreaterThan 1

		it 'should have a jumbrotron element for feature title and body', ->
			browser.sleep 1
			expect(j$.element('.jumbotron').count()).toEqual 1


	###*
  Register - The user registration implementation
  ###
	describe 'Register: ', ->
		beforeEach ->
			registerPage.get()

		it 'should have email and password inputs with a button to submit the form', ->
			expect(browser().location().path()).toEqual '/register'
			expect(element('form', 'Login form').count()).toEqual 1
			expect(element('input[name="email"]', 'Email input').count()).toEqual 1
			expect(element('input[name="username"]', 'Username input').count()).toEqual 1
			expect(element('input[name="password"]', 'Password input').count()).toEqual 2
			expect(element('button[type="submit"]', 'Submit button').count()).toEqual 1

		it 'should allow the user to create a new account', ->
			registerPage.register()
			expect(browser().location().path()).toEqual '/register'
			sleep 1
			expect(browser().location().path()).toEqual '/dashboard'


	###*
	 Login - The user login implementation
	###
	describe 'Login:', ->

		#Click the login button each time
		beforeEach ->
			element('a[href="#/login"]', 'Login button').click()

		#Make sure we end up at the login page to enter our credentials
		#Make sure there is a username and password input with button
		it 'should have Username and password inputs with a button to submit the form', ->
			expect(browser().location().path()).toEqual '/login'
			expect(element('form', 'Login form').count()).toEqual 1
			expect(element('input[name="username"]', 'Username input').count()).toEqual 1
			expect(element('input[name="password"]', 'Password input').count()).toEqual 1
			expect(element('button[type="submit"]', 'Submit button').count()).toEqual 1

			#Login to the page
			loginPage.login()

			#Wait for the api call to go thru
			sleep 1
			#We should end up at the dashboard page.
			expect(browser().location().path()).toEqual '/dashboard'

	#The dashboard implementation
	describe 'Dashboard: viewing the dashboard...', ->
		beforeEach ->
			loginPage.login()
			browser.sleep 1

		#Profile page
		it 'should have a link to the profile page', ->
			expect(j$.element('.widget', 'Widget Panel').count()).toEqual 2
			expect(j$.element('a[ng-href="#/profile"]', 'the Profile link').count()).toEqual 1
			expect(j$.element('.cms-sidebar-nav', 'Sidebar nav').count()).toEqual 1

  usersPage = null
  describe "Users Page:", ->
    beforeEach ->
      usersPage = new UsersPage()
      usersPage.get()
    it "should be able to create a new user", ->
      username = "protractor" + Date.now()
      usersPage.setForm username + "@test.com", username, "test", "John Doe", "This is an example user."

#The user registration implementation


#The user forgot password implementation


# The CRUD operations on DB implementation


# User table


#User form