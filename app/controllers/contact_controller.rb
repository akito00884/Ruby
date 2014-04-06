# coding: utf-8

class ContactController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      ContactMailer.sent(@contact).deliver
      redirect_to :action => :index, :notice => 'お問い合わせありがとうございました。'
    else
      render :action => :index, :alert => 'お問い合わせに不備があります。'
    end
  end

  def index
    @notice = params[:notice]
  end

end