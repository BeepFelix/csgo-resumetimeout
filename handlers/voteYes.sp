void voteYes(int client) {
	Handle castVote = CreateEvent("vote_cast");
	SetEventInt(castVote, "vote_option", 0);
	SetEventInt(castVote, "team", -1);
	SetEventInt(castVote, "entityid", client);
	FireEvent(castVote);

	int entity = FindEntityByClassname(-1, "vote_controller");
	if (entity < 0) {
		return;
	}

	alreadyVoted[client] = true;

	int curVotes = GetEntProp(entity, Prop_Send, "m_nVoteOptionCount", -1, 0); // Get yes votes
	curVotes += 1; // Increase yes votes
	SetEntProp(entity, Prop_Send, "m_nVoteOptionCount", curVotes, _, 0); // Set yes votes
	
	CreateTimer(0.5, Timer_GetResults, GetClientUserId(client));
}
