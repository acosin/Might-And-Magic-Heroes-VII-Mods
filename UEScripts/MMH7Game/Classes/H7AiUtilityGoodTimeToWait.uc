//=============================================================================
// H7AiUtilityGoodTimeToWait
//=============================================================================
// 
//=============================================================================
// Copyright 2013-2015 Limbic Entertainment All Rights Reserved.
//=============================================================================
class H7AiUtilityGoodTimeToWait extends H7AiUtilitySensor;

/// overrides ...

function UpdateInput()
{
	local H7AiCombatSensors sensors;
	mInValues.Remove(0,mInValues.Length);
	sensors = class'H7CombatController'.static.GetInstance().GetAI().GetSensors();
	sensors.CallBegin( mInSensorConst0, mInSensorConst1 );
	while( sensors.CallNext() == true )
	{
		mInValues.AddItem( sensors.CallSensor(ACS_GoodTimeToWait) );
	}

}

function UpdateOutput()
{
	ApplyFunction();
	ApplyOutputWeigth();
}

/// functions

