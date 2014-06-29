class StaticPagesController < ApplicationController
  def home
    @url = 'http://worldcup.kimonolabs.com/api/'
    @players = 'players?'
    @clubs = 'clubs/'
    @teams = 'teams'
    @matches = 'matches'
    @api = '&apikey=' + ENV['APIKEY']
    @api2 = '?apikey=' + ENV['APIKEY']
    
      @mostgoals_list = JSON.parse(RestClient.get(@url + @players + 'sort=goals,-1' + @api))
      @teamgoals_list = JSON.parse(RestClient.get(@url + @teams + '?sort=goalsFor,-1' + @api))
      @nextmatch_list = JSON.parse(RestClient.get(@url + @matches + '?sort=startTime,1' + @api))
        @nextmatch_list.each do |match|
          if match['status'] == 'Pre-game'
            @nextmatch_hometeam = JSON.parse(RestClient.get(@url + @teams + '/' + match['homeTeamId'] + @api2))
            @nextmatch_awayteam = JSON.parse(RestClient.get(@url + @teams + '/' + match['awayTeamId'] + @api2))
            @nextmatch_time = match['startTime'].to_time
            @nextmatch_location = match['venue']
            return
          end
        end
        
   end
  
end
