$ rails new pin_board
$ rails s # just for a check

$ cd pin_board
$ sublime .

Search for 'haml' gem
https://rubygems.org/gems/haml/
paste 'haml' gem to gemfile
		gem 'haml', '~> 4.0.6'

Search for 'bootstrap-sass' gem
https://rubygems.org/gems/bootstrap-sass
paste 'bootstrap-sass' gem to gemfile
		gem 'bootstrap-sass', '~> 3.3.5.1'

Search for ‘simple_form’ gem
https://rubygems.org/gems/simple_form
paste 'simple_form' gem to gemfile
		gem 'simple_form', '~> 3.1.0'


$ bundle install
$ rails g model Pin title:string description:text
$ rake db:migrate
$ rails g controller Pins


—> app/controllers/pins_controller.rb
		def index
		end 


—> app/config/routes.rb
		resources :pins
		root "pins#index"


—> app/views/pins
create new file : index.html.haml
		%h1 This is the index placeholder


—> app/controllers/pins_controller.rb
		def new
			@pin = Pin.new
		end

		def create
			@pin = Pin.new(pin_params)
		end

		private

		def pin_params
			params.require(:pin).permit(:title, :description)
		end


-> app/views/pins
create new file : new.html.haml
		%h1 New Form
		= render 'form'
		= link_to "Back", root_path


create new file : _form.html.haml
		

Search for simple_form at GitHub, see the docs
https://github.com/plataformatec/simple_form#bootstrap
we need to install with bootstrap, so
$ rails generate simple_form:install --bootstrap


back to _form.html.haml
		= simple_form_for @pin, html: { multipart: true } do |f|
			- if @pin.errors.any?
				#errors
					%h2
					= pluralize(@pin.errors.count, "error")
					prevented this Pin from saving
					%ul
						- @pin.errors.full_messages.each do |msg|
							%li = msg

			.form-group
				= f.input :title, input_html: {class:'form-control'}

			.form-group
				= f.input :description, input_html: {class: 'form-contral'}
			= f.button :submit, class: "btn btn-primary"


—> app/controllers/pins_controller.rb
		def create
			@pin = Pin.new(pin_params)

			if @pin.save
				redirect_to @pin, notice: "Successfully created new Pin"
			else
				render 'new'
			end
		end

—> app/views/layouts/application.html.haml
		!!!5
		%html
		%head
			%title PinBoard
			= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true
			= javascript_include_tag 'application', 'data-turbolinks-track' => true
			= csrf_meta_tags
		%body
			- flash.each do |name, msg|
				= content_tag :div, msg, class: "alert alert-info"

			=yield

—> app/controllers/pins_controller.rb
		def index
		end

		def show
		end

		def new
			@pin = Pin.new
		end
		
		...

		private

		def pin_params
			params.require(:pin).permit(:title, :description)
		end

		def find_pin
			@pin = Pin.find(params[:id])
		end


============
coffee 檔的使用方式要懂
