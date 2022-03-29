Моб может находиться в одном из состояний:

* stroll - прогулка
* rest - отдых
* runaway - бегство
* aggression - проявление агрессии к цели
* goto_target - движение к цели
* attack - атака цели

-- right_mobs_ai:register_mob(name, definition)

Регистрация нового типа моба

функции

* on_punched(context, puncher, attributes) - обработка удара по мобу
* on_target_lost(context) - обработка потери цели
* think(context, position, velocity, dtime) - функция принятия решения о дальнейшем поведении
* select_attack(context, position, velocity) - выбор типа атаки (ближний или дальний бой)

Имплементация действий

* attack(context, target, type, userdata) - атаковать цель
* walk(context, current_position, target_position, speed, userdata) - идти в указанную точку
* stay(context, userdata) - стоять на месте

-- right_mobs_ai:init_new_mob(name, userdata, parameters)

Создать нового моба с типом `name`

parameters может содержать поля

* available_attacks - список возможных атак (ближний, дальний бой)
* stroll_speed - скорость при прогулке
* runaway_speed - скорость бегства
* targeting_speed - скорость при следовании к цели
* aggression_time - сколько продолжается агрессия моба
* aggression_period - период проявления агрессивности пока моб находится в состоянии агрессии 

-- right_mobs_ai:punch(context, puncher, attributes)

Ударить моба

-- right_mobs_ai:get_targets(context)

Список объектов, которых отслеживает моб

-- right_mobs_ai:target_lost(context, target)

Сообщить мобу, что одна из его целей более не существует или недоступна

-- right_mobs_ai:init_from_serialized(serialized)

Инициализировать AI моба из сериализованного описания

-- right_mobs_ai:serialize(context)

Сериализовать AI-контекст моба
