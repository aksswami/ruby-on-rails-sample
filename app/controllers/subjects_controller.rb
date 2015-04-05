class SubjectsController < ApplicationController

  layout false
  def index
    @subjects = Subject.sorted
  end

  def show
    @subject =Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})

  end

  def create
    @subject = Subject.new(subject_params)

    # Save the object
    if @subject.save
      # If save succeds, redirect to the index action
      flash[:notice] = "Subject created successfully"
      redirect_to(:action => 'index')
    else
      # if save fails, redisply the form so user can fix the problem
      render('new')
    end
  end

  def edit
    @subject =Subject.find(params[:id])

  end

  def update
    # Find an existing object using the parameters
    @subject = Subject.find(params[:id])
    #Update the object
    if @subject.update_attributes(subject_params)
      # If save succeds, redirect to the index action
      flash[:notice] = "Subject updated successfully"
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # if save fails, redisply the form so user can fix the problem
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destoryed successfully"
    redirect_to(:action => 'index')
  end

  private

    def subject_params
      #same as using "params[:subject]", except that it:
      # - raised  an error if :subject is not present
      # - allow listed  attributes to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible)
      
    end
end
