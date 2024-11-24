/*
	Functions used for player movement
*/

function	set_sprites(_idle, _moving, _front, _back)
{
	return
	{
		idle	: _idle,
		moving	: _moving,
		front	: _front,
		back	: _back,
	}
}

function	player_get_commands()
{
	var _right		= keyboard_check(ord("D"));
	var _left		= keyboard_check(ord("A"));
	var _up			= keyboard_check(ord("W"));
	var _down		= keyboard_check(ord("S"));
	var _is_moving	= _up || _down || _right || _left;

	return 
	{
		right		: _right,
		left		: _left,
		up			: _up,
		down		: _down,
		is_moving	: _is_moving,
	}
}

function	get_sign(n)
{
	return ((n > 0) - (n < 0));
}

function	vertical_walking(_direction_speed, spr_back, spr_front)
{
	var _vMove, _vSpeed;
	
	if (!_direction_speed)
		return (0);
	_vSpeed		= _direction_speed;
	_vMove		= get_sign(_vSpeed);
	if (_vMove < 0 && spr_back)
		sprite_index = spr_back;
	else if (_vMove > 0 && spr_front)
		sprite_index = spr_front;
	y += _vSpeed;
	return (1);
}

function	horizontal_walking(_direction_speed, spr_moving)
{
	var	_hMove, _hSpeed;

	if (!_direction_speed || !spr_moving)
		return (0);
	_hSpeed		= _direction_speed;
	_hMove		= get_sign(_hSpeed);
	if (_hMove)
	{
		image_xscale = _hMove;
		sprite_index	= spr_moving;
	}
	x += _hSpeed;
	return (1);
}

function	walking(move_direction_x, move_direction_y, move_speed, spr_array)
{
	var	_hMove, _vMove, _hSpeed, _vSpeed;
	
	if (!move_direction_x || !move_direction_y || !move_speed)
		return (0);
	_hMove = move_direction_x;
	_vMove = move_direction_y;
	//Vector normalize if walking in diagonal
	if (_hMove != 0 && _vMove != 0)
	{
		var	vector_length	= sqrt(sqr(_hMove) + sqr(_vMove));
		_hSpeed				= (_hMove / vector_length) * move_speed;
		_vSpeed				= (_vMove / vector_length) * move_speed;
	}
	else
	{
		_hSpeed		= _hMove * move_speed;
		_vSpeed		= _vMove * move_speed;
	}
	horizontal_walking(_hSpeed, spr_array.moving);
	vertical_walking(_vSpeed, spr_array.back, spr_array.front);
	return (1);
}
