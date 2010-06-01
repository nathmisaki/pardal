class DisciplineType < EnumerateIt::Base
  associate_values( :obrigatoria => [1, 'OBRIGATORIA'],
                   :complementar => [2, 'COMPLEMENTAR'],
                       :optativa => [3, 'OPTATIVA'],
                    :suplementar => [4, 'SUPLEMENTAR'],
                        :eletiva => [5, 'ELETIVA']
  )

  #def initialize(value)
    #@value = value
  #end

  #def desc
    #Hash[*to_a]
  #end
end
