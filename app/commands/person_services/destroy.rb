module PersonServices
  class Destroy
    include Wisper::Publisher

    def initialize(params)
      @params = params
    end

    def call
      error_messages = validate_params
      if error_messages.empty?
        try_destroy
      else
        broadcast(:failed, error_messages)
      end
    end

    private

    def try_destroy
      person = Person.where(id: @params[:id]).first
      if person
        begin
          person.destroy
          broadcast(:successfully, {})
        rescue StandardError => ex
          broadcast(:failed, error: ex.cause)
        end
      else
        broadcast(:not_found, message: 'Not found')
      end
    end

    def validate_params
      schema = Dry::Validation.Schema do
        required(:id).filled
      end
      schema.call(@params).messages
    end
  end

end