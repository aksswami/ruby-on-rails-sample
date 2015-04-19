class SectionsController < ApplicationController

  layout "admin" 

  def index
    @page = Page.find(params[:page_id])
    @sections = @page.sections
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @page = Page.find(params[:page_id])
    @section = Section.new({:name => "Default Section"})
  end

  def create
    page = Page.find(params[:page_id])
    section = Section.new(section_params)
    page.sections << section
    if section.save
      flash[:notice] = "Section '#{section.name}' saved successfully."
      redirect_to(:action => 'index', :page_id => section.page_id)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @page = Page.find(params[:page_id])
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section '#{@section.name}' updated successfully."
      redirect_to(:action => 'index', :page_id => @section.page_id)
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed successfully."
    redirect_to(:action => 'index', :page_id => section.page_id)
    
  end

  private

  def section_params
    params.require(:section).permit(:name, :position, :visible, :content_type, :content)
  end
end
