Dir[File.join(Rails.root, 'lib', 'monkeys', '*.rb')].each { |file| require file }
