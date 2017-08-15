class ContactController < ApplicationController
    protect_from_forgery with: :exception
    def new
       @contact = Contact.new
    end

    def create
       @contact = Contact.new(contact_params)
       @contact.save
    end
end