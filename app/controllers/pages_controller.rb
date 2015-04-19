class PagesController < ApplicationController
  
  layout "admin"

  def index
    @subject = Subject.find(params[:subject_id])
    @pages = @subject.pages.sorted 

  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:name => "Default"})
    @subject = Subject.find(params[:subject_id])
  end

  def create
    page = Page.new(page_params)
    subject = Subject.find(params[:subject_id])
    subject.pages << page
    if page.save
      flash[:notice] = "Page '#{page.name}' saved successfully"
      redirect_to(:controller => 'pages', :action => 'index', :subject_id => subject.id)
    else
      flash[:notice] = "Page not saved."
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page '#{@page.name}' updated successfully"
      redirect_to(:controller => 'pages', :action => 'index', :subject_id => @page.subject_id)
    else
      flash[:notice] = "Page not updated."
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully"
    redirect_to(:action => 'index', :subject_id => page.subject_id)
    
  end


  private
   def page_params
      params.require(:page).permit(:name, :permalink, :position, :visible)
   end


end
