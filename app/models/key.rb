class Key < ActiveRecord::Base
  attr_accessible :word

	validates_presence_of :word
	validates_uniqueness_of :word
	
	#Builds a comma seperated list of keywords
	def self.words
		keywords = self.all.map { |key| key.word }
		keywords.compact.join(', ')
	end
	
end
