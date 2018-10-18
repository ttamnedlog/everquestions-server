-- Zone: provinggrounds
-- NCP.: Projection_Of_Tactics (316038)
--

function event_spawn(e)
  eq.set_proximity(e.self:GetX()+10, e.self:GetY()+10, e.self:GetX()-10, e.self:GetY()-10);
end

function event_enter(e)
    e.self:Say("Perception and split-second reactions are not something you can acquire in training.  It's a gift learned on the battlefield, and the penalty for being a slow learner is a quick and decisive death.  Can you see the arrow as it sails toward your heart and sidestep out of the way?  If you have this ability, now is the opportunity to prove your worth!");
end

function event_say(e)
  if (e.message:findi("hail")) then
    e.self:Say("Halt, Dark Elf, and hear my words.  Your background and your status are of no consequence.  All are welcome to participate in the trials to prove their worth, or die trying.  Whosoever approaches me has addressed the embodiment of Tactics, keeper of the trials of Subversion and Foresight.  The former is a small-scale test, while the latter is large-scale.  My task is to explain the rules and usher hopefuls into the battle arena.  Would you like to hear the rules for [ " .. eq.say_link('small-scale') .. " ] or [large-scale] trials, or do you wish to enroll in [ " .. eq.say_link('Subversion', false, 'Subversion') .. " ] or [ " .. eq.say_link('Foresight', false, 'Foresight') .. " ]?");

  elseif (e.message:findi("Subversion")) then
    local instance_requests = require("instance_requests");
    local lockouts = { { 'MPG_subversion', 'MPG: Trial of Subversion' } } 
    local requests = instance_requests.ValidateRequest('group', 'chambersc', 1, 2, 6, 65, nil, nil, e.other, lockouts);
    if (requests.valid and requests.flags == 1) then
      instance_requests.DisplayLockouts(e.other, e.other, lockouts);
    elseif (requests.valid and requests.flags == 0) then
      local instance_id = eq.create_instance('chambersc', 1, 3600);
      eq.assign_group_to_instance(instance_id);

      e.self:Say("Knowing when to thwart your opponents using guile and subversion instead of brute force is critical to attaining true power.  Wealth can be amassed without ever unsheathing a blade.  The most ambitious rulers are overthrown not by their enemies on the battlefield, but by their 'allies' in the throne room.  If you understand my meaning, now is the opportunity to prove your worth!");
    end

  elseif (e.message:findi("Foresight")) then
    local instance_requests = require("instance_requests");
    local lockouts = { { 'MPG_foresight', 'MPG: Trial of Foresight' } }
    local requests = instance_requests.ValidateRequest('raid',  'chambersc', 2, 2, 54, 65, nil, nil, e.other, lockouts);
    if (requests.valid and requests.flags == 1) then
      instance_requests.DisplayLockouts(e.other, e.other, lockouts);
    elseif (requests.valid and requests.flags == 0) then
      local instance_id = eq.create_instance('chambersc', 2, 10800);
      eq.assign_raid_to_instance(instance_id);
      eq.cross_zone_message_player_by_name(5, "GMFizban", "Mastery of Foresight -- Instance: " .. instance_id);

      e.self:Say("Perception and split-second reactions are not something you can acquire in training. It's a gift learned on the battlefield, and the penalty for being a slow learner is a quick and decisive death. Can you see the arrow as it sails towards your heart and sidestep out of the way? If you have this ability now is the opportunity to prove your worth.");
    end
  elseif (e.message:findi('small') ) then
    e.self:Say("'Every test has its rules and these trials are no exception. The following guidelines must be followed to the letter, or else you stand to forfeit or perish. You are allowed no more than six participants in the battle. Once the trial has begun, you must remain in the combat area. Violators of this rule will be warned and then destroyed. Your [ ".. eq.say_link('progress') .. " ] will be carefully monitored. If you take too long, you will fail. These are the rules and they are not negotiable.'");
  elseif (e.message:findi("progress")) then
    local mpg_helper = require("mpg_helper");
    mpg_helper.Display_Group_Trials_Completed(e.other);
  elseif (e.message:findi('raids')) then
    local mpg_helper = require("mpg_helper");
    mpg_helper.Display_Completed_Trials(e.other);
  end
end
