class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def show
    @mailing_list = @contact.mailing_lists.first
  end

  def new
    @contact = Contact.new
    @mailing_list_id = params[:mailing_list_id]
  end

  def create
    @contact = Contact.new(contact_params)
    @mailing_list = MailingList.find(params[:contact][:mailing_list_id])
    @contact.mailing_lists = [@mailing_list]
    if @contact.save
      redirect_to @mailing_list
    else
      render :new
    end
  end

  def edit
  end

  def update
    @contact.update(contact_params)
    if @contact.save
      redirect_to @contact
    else
      render :edit
    end
  end

  def destroy
    mailing_list = @contact.mailing_lists.first
    @contact.destroy
    redirect_to mailing_list_path(mailing_list)
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(
      :phone_number,
      :first_name,
      :last_name,
      :zip_code
      ).except(:mailing_list_id)
  end
end
