class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :not_valid_response
rescue_from ActiveRecord::RecordNotFound, with :not_found_response

def index
    render json: Instructor.all
end

def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor status: :created
end

def update
    @instructor.update!(instructor_params)
    render json: @instructor, status: :accepted
end

def destroy
    @instructor.destroy
    head :no_content
end

private

def instructor_params
    params.permit(:name)
end

def set_instructor
    @instructor = Instructor.find(params[:id])
end

def not_valid_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end

def not_found_response
    render json: {error: "Instructor not found"}, status: :not_found
end
end
