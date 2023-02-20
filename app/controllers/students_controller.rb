class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :not_valid_response
rescue_from ActiveRecord::RecordNotFound, with :not_found_response

def index
    render json: Student.all
end

def create
    student = Student.create!(student_params)
    render json: student, serializer: StudentInstructorSerializer, status: :created
end

def update
    @student.update!(student_params)
    render json: @student, serializer: StudentInstructorSerializer, status: :accepted
end

def destroy
    @student.destroy
    head :no_content
end

private

def student_params
    params.permit(:name, :major, :age, :instructor_id)
end

def set_student
    @student = Student.find(params[:id])
end

def not_valid_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end

def not_found_response
    render json: {error: "Student not found"}, status: :not_found
end

end
