extends Node2D

var m_engine_starteed = false
var m_accelerate = false

var m_start_engine_snd = null
var m_accelerate_snd = null
var m_engine_noise_snd = null

var m_speed = 1.0
var m_acceleration = 0.0
var m_max_speed_reached = false
var m_gear = 0
var m_max_gear = 6
var m_starting_speed = 1.0

func _process(delta):
	if(m_accelerate):
		m_acceleration = 1.0
		var attenuation = delta * 0.5 # play with this value
		var curr_speed = m_speed * attenuation + m_acceleration * attenuation * attenuation * 0.5
		if(m_gear < m_max_gear):
			m_speed += curr_speed
			if(m_speed >= 5.0):
				m_max_speed_reached = true
			if(m_max_speed_reached):
				m_max_speed_reached = false
				m_gear += 1
				if(m_gear < m_max_gear):
					m_starting_speed += 1.0
					m_speed = m_starting_speed

		var bus_effect = AudioServer.get_bus_effect(AudioServer.get_bus_index("Master"),0)
		bus_effect.set("pitch_scale",m_speed)

func _on_start_engine_pressed():
	if(!m_engine_starteed):
		m_engine_starteed = true
		m_start_engine_snd = get_node("start_engine_snd")
		m_accelerate_snd = get_node("accelerate_snd")
		m_engine_noise_snd = get_node("engine_noise_snd")
		m_start_engine_snd.play()
		m_accelerate_snd.play()
		m_engine_noise_snd.play()

func _on_accelerate_pressed():
	m_accelerate = true
