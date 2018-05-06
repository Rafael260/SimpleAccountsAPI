module PersonServices
  class Create
    include Wisper::Publisher
    def initialize(params)
      @params = params
    end

    def call
      error_messages = validate
      if error_messages.empty?
        try_create
      else
        broadcast(:failed, error_messages)
      end
    end

    private

    def try_create
      person = Person.new(@params)
      person.save
      broadcast(:successfully, person)
    rescue StandardError => ex
      broadcast(:failed, error: ex.cause)
    end

    def validate
      schema = Dry::Validation.Schema do
        required(:name).filled(:str?)
        required(:reason).filled(:str?)
        required(:cnpj).filled(:str?) # caberia mais validacoes, apenas numeros etc
      end
      schema.call(@params).messages
    end
  end
end