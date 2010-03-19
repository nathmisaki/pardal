class Anexo < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true
end
