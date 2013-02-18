module Dust
  class ContactsController < ApplicationController

    require "csv"

    filter_access_to :all

    layout 'cms'

    def index
      @contacts = Dust::Contact.page(params[:search], params[:page], params[:date])
    end

    def new
      @contact = Dust::Contact.new
    end

    def create
      @page = Dust::Page.find(1)
      @contact = Dust::Contact.new(params[:dust_contact])
      if @contact.save
        @contact.deliver_messages
        flash[:notice] = "Successfully Sent Message."
        redirect_to root_url
      else
        render :action => 'new', :layout => 'application'
      end
    end

    def edit
      @contact = Dust::Contact.find(params[:id])
    end

    def update
      @contact = Dust::Contact.find(params[:id])
      if @contact.update_attributes(params[:dust_contact])
        flash[:notice] = "Successfully updated contact."
        redirect_to @contact
      else
        render :action => 'edit'
      end
    end

    def destroy
      @contact = Dust::Contact.find(params[:id])
      @contact.destroy
      flash[:notice] = "Successfully destroyed contact."
      redirect_to dust_contacts_url
    end

    def csv
      @contacts = Dust::Contact.order("created_at DESC")
      if @contacts.empty?
        flash[:error] = "There are no contact requests available."
        redirect_to dust_contacts_path
      else
        csv_string = CSV.generate do |csv|
          csv << ["Name", "Email", "message"]
          @contacts.each do |contact|
            csv << [contact['name'], contact['email'], contact['message']]
          end
        end

        send_data(csv_string,
                  :type => 'text/csv; charset=utf-8; header=present',
                  :filename => "AllDust::Contacts#{Date.today}.csv"
                 )
      end
    end

    def csv_import
      csv = CSV.new(params[:csv_import][:file])
      csv.each do |row|
        Dust::Contact.create(:name => row[0], 
                             :email => row[1],
                             :message => row[2]
                            )
      end
      csv.close
      flash[:notice] = "Successfully added some Dust::Contact(s)."
      redirect_to contacts_path
    rescue => exception
      # If an exception is thrown, the transaction rolls back and we end up in this rescue block
      error = ERB::Util.h(exception.to_s) # get the error and HTML escape it
      flash[:error] = "Error adding logs. (some #{error}). Please try again."
      redirect_to contacts_path
    end
  end
end
