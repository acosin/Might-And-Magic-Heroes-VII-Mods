//=============================================================================
// H7AiUtilityCrAbilityFeralCharge
//=============================================================================
// (ACTIVE)
// The creature moves to the targeted enemy creature (no matter how far it is) 
// and attacks it. The creature gets +5 attack and the attacked enemy creature 
// cannot retaliate. The creatures defense is then set to 0 (defense buffs are 
// ignored) until its next turn.
//=============================================================================
// Copyright 2013-2015 Limbic Entertainment All Rights Reserved.
//=============================================================================
class H7AiUtilityCrAbilityFeralCharge extends H7AiUtilityCombiner;

var protected H7AiUtilityCrAbilityCasualityCount    mInUCasualityCount;
var protected H7AiUtilityCrAbilityCreatureDamage    mInUCreatureDamage;
var protected H7AiUtilityCanMoveAttack              mUMoveAttack;

/// overrides ...
function UpdateInput()
{
	local array<float> casualityCount;
	local array<float> creatureDamage;
	local array<float> moveAttack;
	local float coUtil;

	if( ( class'H7AdventureController'.static.GetInstance() != none && class'H7AdventureController'.static.GetInstance().GetConfig().mAiAdvMapConfig.mConfigOutputToLog ) || class'H7AdventureController'.static.GetInstance() == none ) ;

	if( mInUCasualityCount == None ) { mInUCasualityCount = new class 'H7AiUtilityCrAbilityCasualityCount'; }
	if( mInUCreatureDamage == None ) { mInUCreatureDamage = new class 'H7AiUtilityCrAbilityCreatureDamage'; }
	if( mUMoveAttack ==  None ) { mUMoveAttack = new class 'H7AiUtilityCanMoveAttack'; }

	mInValues.Remove(0,mInValues.Length);

	mUMoveAttack.UpdateInput();
	mUMoveAttack.UpdateOutput();
	moveAttack = mUMoveAttack.GetOutValues();
	if(moveAttack.Length>0 && moveAttack[0]>0.0f)
	{
		mInUCasualityCount.UpdateInput();
		mInUCasualityCount.UpdateOutput();
		casualityCount = mInUCasualityCount.GetOutValues();

		mInUCreatureDamage.UpdateInput();
		mInUCreatureDamage.UpdateOutput();
		creatureDamage = mInUCreatureDamage.GetOutValues();

		if(casualityCount.Length>=1 && creatureDamage.Length>=1)
		{
			coUtil=casualityCount[0]*creatureDamage[0];
			if( ( class'H7AdventureController'.static.GetInstance() != none && class'H7AdventureController'.static.GetInstance().GetConfig().mAiAdvMapConfig.mConfigOutputToLog ) || class'H7AdventureController'.static.GetInstance() == none ) ;
			if(coUtil>0.0f)
			{
				mInValues.AddItem(coUtil);
			}
		}
	}
}

function UpdateOutput()
{
	ApplyFunction();
	ApplyOutputWeigth();
}

/// functions
