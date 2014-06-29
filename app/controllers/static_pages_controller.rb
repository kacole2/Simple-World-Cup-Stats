class StaticPagesController < ApplicationController
  def home
    @url = 'http://worldcup.kimonolabs.com/api/'
    @players = 'players?'
    @clubs = 'clubs/'
    @teams = 'teams'
    @matches = 'matches'
    @api = '&apikey=' + ENV['APIKEY']
    @api2 = '?apikey=' + ENV['APIKEY']
    @wcwinner = 0
    
    @mostgoals_list = JSON.parse(RestClient.get(@url + @players + 'sort=goals,-1' + @api))
    @teamgoals_list = JSON.parse(RestClient.get(@url + @teams + '?sort=goalsFor,-1' + @api))
      
    @nextmatch_list = JSON.parse(RestClient.get(@url + @matches + '?sort=startTime,1' + @api))
      @nextmatch_list.each do |match|
          if @wcwinner == 0
              if match['status'] == 'Pre-game'
                @nextmatch_hometeam = JSON.parse(RestClient.get(@url + @teams + '/' + match['homeTeamId'] + @api2))
                @nextmatch_awayteam = JSON.parse(RestClient.get(@url + @teams + '/' + match['awayTeamId'] + @api2))
                @nextmatch_time = match['startTime'].to_time
                @nextmatch_location = match['venue']
                @wcwinner += 1
              end
          end
       end
      
     if @wcwinner == 0   
      @winningmatch_list = JSON.parse(RestClient.get(@url + @matches + '?sort=startTime,-1' + @api))
        puts @winningmatch_list
          @winningmatch_hometeam = JSON.parse(RestClient.get(@url + @teams + '/' + @winningmatch_list[0]['homeTeamId'] + @api2))
          @winningmatch_homescore = @winningmatch_list[0]['homeScore']
          @winningmatch_awayteam = JSON.parse(RestClient.get(@url + @teams + '/' + @winningmatch_list[0]['awayTeamId'] + @api2))
          @winningmatch_awayscore = @winningmatch_list[0]['awayScore']
          @winningmatch_location = @winningmatch_list[0]['venue']
          @winningmatch_time = @winningmatch_list[0]['startTime'].to_time
        
          if @winningmatch_homescore > @winningmatch_awayscore
            @winningteam = @winningmatch_hometeam
          else
            @winningteam = @nwinningmatch_awayteam
          end
      end
   end  
end
