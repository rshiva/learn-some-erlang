-module(records).
-compile(export_all).

-record(robot, {name,
                type=industrial,
                hobbies,
                details=[]}).

first_robot() ->
  #robot{name="Megatron",
        type=handmade,
        details=["Moved by a small man inside"]}.

car_corp(CompanyName) ->
  #robot{name=CompanyName,
        hobbies="Self driving"}.

%update a record
repair_man(Rob) ->
  Details =  Rob#robot.details,
  NewRob = Rob#robot{details=["Repaired by repairman"|Details]},
  {repaired,NewRob}.