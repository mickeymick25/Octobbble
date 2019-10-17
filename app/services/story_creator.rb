class StoryCreator
  attr_reader :input

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(octopod_id)
    @octopod_id = octopod_id
  end

  def call
    if (@octopod_id)
      initialize_from_octopod
    else
      Project.new
    end
  end

  def initialize_from_octopod
    octopod_client = OctopodApi::V0::Client.new
    octopod_project = octopod_client.project(@octopod_id)
    if octopod_project
      Rails.logger.info("Found octopod project #{octopod_project.name}")
      Project.new(title: octopod_project.name, description: octopod_project.description, clientname: octopod_project.customer)  
    else
      Rails.logger.info("No matching octopod project")
      Project.new
    end
  end
end
