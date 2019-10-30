class TeamCreator
  attr_reader :input

  def self.team(*args, &block)
    new(*args, &block).team
  end

  def initialize(octopod_id)
    @octopod_id = octopod_id
  end

  def team
    if (@octopod_id)
      get_project_team_from_octopod
    else
      #Project.new
      []
    end
  end

  def get_project_team_from_octopod
    octopod_client = OctopodApi::V0::Client.new
    octopod_project = octopod_client.project(@octopod_id)
    if octopod_project
      octopod_activities = octopod_client.activities(@octopod_id)
      if octopod_activities
        members = octopod_activities.map { |entry|
          #Rails.logger.info("Octopod_team_member_people:: "+  entry.inspect )
          entry[:people].map{ |i|
            #Rails.logger.info("Octopod_team_member_people:: "+  i[:last_name] )
            #Rails.logger.info("Octopod_team_member_people:: "+  i[:first_name] )
            OctopodApi::V0::People.new(title: entry[:title], last_name: i[:last_name], first_name: i[:first_name], nickname: i[:nickname] )
          }
        }.flatten.group_by{|member| member.activity_title}
        Rails.logger.info(members)
        members
      else
      end
    end
  end

end
