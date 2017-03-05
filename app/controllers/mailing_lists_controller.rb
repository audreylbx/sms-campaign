class MailingListsController < ApplicationController
  before_action :set_mailing_list, only: [:edit, :update, :show, :upload_csv, :import_csv, :import_csv_results, :destroy]

  def index
    @mailing_lists = MailingList.where("user_id = #{current_user.id}")
  end

  def new
    @mailing_list = MailingList.new
    @mailing_list.user = current_user
    @mailing_list.save
  end

  def show
  end

  def create
    @mailing_list = MailingList.new(mailing_list_params)
    @mailing_list.user = current_user
    if @mailing_list.save
      if params[:mailing_list][:import_type] == "csv"
        redirect_to :action => :import_csv, :id => @mailing_list.id
      else
        redirect_to :action => :index
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    @mailing_list.update(mailing_list_params)
    if @mailing_list.save
      render :index
    else
      render :edit
    end
  end

  def upload_csv
  end

  def import_csv
  end

  def import_csv_results
  end

  def destroy
    @mailing_list.destroy
    redirect_to mailing_lists_path
  end

  private

  def set_mailing_list
    @mailing_list = MailingList.find(params[:id])
  end

  def mailing_list_params
    params.require(:mailing_list).permit(:name, :import_type).except(:import_type)
  end
end
