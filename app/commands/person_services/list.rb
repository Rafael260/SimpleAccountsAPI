module PersonServices
  class List
    include Wisper::Publisher
  
    def call
      people = Person.all
      broadcast(:successfully, people)
    end
  end
end