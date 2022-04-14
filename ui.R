#
ui <- dashboardPage(
  skin = "blue",
  title = "DataKC",
  
  # HEADER--------------------------------------------------------------------
  dashboardHeader(title =  span("DataKC"),
                  titleWidth = 230),
  # SIDEBAR------------------------------------------------------------------
  dashboardSidebar(sidebarMenu(
    menuItem("MAR 2022",
             tabName = "Resident_Survey_2022",
             icon = icon("keyboard")),
    menuItem("AUG 2021",
             tabName = "Resident_Survey",
             icon = icon("city")),
    menuItem("MAR 2021",
             tabName = "Resident_survey_mar_2021",
             icon = icon("cat"))

  )),
  # BODY --------------------------------------------------------------------
  dashboardBody(useShinyjs(),
                introjsUI(),
                
                ## MAIN BODY-------------------------------------------------------------
                tabItems(
                  ### AUG 2021---------------------------------
                  tabItem(
                    "Resident_Survey",
                    fluidRow(box(
                                 width = 12,
                                 div(style = "height: 50px; font-size: 40px;",
                                     "August 2021 Resident Survey Dashboard"))
                             ),
                    fluidRow(
                      box(width = 12,
                          p(style = "height: 10px; font-size: 12px;",
                            "Select two variables from the drop boxes below."),
                          p(style = "height: 10px; font-size: 12px;",
                            "Chi-Squared and other statistic of the two variables is shown below."),
                          p(style = "height: 30px; font-size: 12px;",
                            "Cramer's V is a number between 0 and 1. The closer the Cramer's V is to 1, the stronger the relationship is between the two variables. Scores above .10 are weakly associated. Scores above .4 are strongly related."),
                          p(style = "height: 10px; font-size: 12px;",
                            "P-values should be smaller than .02 to be statistically significant."))
                    ),
                    fluidRow(
                      box(
                        selectInput(
                          "ycol",
                          "Y Variables:",
                          c(
                            "method" ,   
                            
                            "q1_01_as_a_place_to_live" ,                                                                                                                                                     
                            "q1_02_as_a_place_to_raise_children"   ,                                                                                                                                         
                            "q1_03_as_a_place_to_work",      
                            
                            "q2_01_overall_quality_of_services_provided_by_the_city"  ,                                                      
                            "q2_02_overall_value_you_receive_for_your_city_tax_dollars_and_fees"    ,                                        
                            "q2_03_overall_image_of_the_city" ,                                                                              
                            "q2_04_overall_quality_of_life_in_the_city" ,                                                                    
                            "q2_05_overall_feeling_of_safety_in_the_city"  ,                                                                 
                            "q2_06_how_safe_you_feel_in_your_neighborhood"    ,                                                              
                            "q2_07_overall_quality_of_education_system_within_the_city" ,                                                    
                            "q2_08_physical_appearance_of_your_neighborhood",  
                            
                            "q3_01_police_services" ,                                                                           
                            "q3_02_fire_and_ambulance_services" ,                                                               
                            "q3_03_the_maintenance_of_city_streets_sidewalks_and_infrastructure" ,                              
                            "q3_04_solid_waste_services"  ,                         
                            "q3_05_city_water_utilities"  ,                                                                     
                            "q3_06_neighborhood_services"  ,          
                            "q3_07_city_parks_and_recreation_programs_facilities"  ,                                            
                            "q3_08_health_department_services",                                                                 
                            "q3_09_airport_facilities",                                                                         
                            "q3_10_the_citys_311_service",                                                                      
                            "q3_11_municipal_court_services" ,                                                                  
                            "q3_12_customer_service_you_receive_from_city_employees"  ,                                         
                            "q3_13_overall_effectiveness_of_city_communication_with_the_public" ,                               
                            "q3_14_the_citys_stormwater_runoff_stormwater_management_system",                                   
                            "q3_15_public_transportation"  ,                                                                    
                            "q3_16_city_planning_and_development_services"  ,                               
                            
                            "q5_01_effectiveness_of_local_police_protection",                                                                                       
                            "q5_02_the_relationship_between_my_neighborhood_and_the_police" ,                                                                        
                            "q5_03_the_citys_overall_efforts_to_prevent_crime" ,                                                                                     
                            "q5_04_enforcement_of_local_traffic_laws",                                                                                               
                            "q5_05_parking_enforcement_services",                                                                                                    
                            "q5_06_how_quickly_police_respond_to_emergencies"   ,                                                                                    
                            "q5_07_responsiveness_of_the_police_department_to_resident_concerns" ,                                                                   
                            
                            "q7_01_overall_quality_of_local_fire_protection_and_rescue_services"   ,                                             
                            "q7_02_how_quickly_fire_and_rescue_personnel_respond_to_emergencies" ,                                               
                            "q7_03_quality_of_local_emergency_medical_service"       ,                                                           
                            "q7_04_how_quickly_emergency_medical_personnel_respond_to_emergencies" ,
                            
                            "q9_01_maintenance_of_city_streets" ,                                                                     
                            "q9_02_maintenance_of_streets_in_your_neighborhood"   ,                                                   
                            "q9_03_condition_of_sidewalks_in_the_city",                                                               
                            "q9_04_condition_of_sidewalks_in_your_neighborhood" ,                                                     
                            "q9_05_maintenance_of_street_signs_and_traffic_signals",                                                  
                            "q9_06_snow_removal_on_major_city_streets_during_the_past_12_months"  ,                                   
                            "q9_07_snow_removal_on_residential_streets_during_the_past_12_months" ,                                   
                            "q9_08_adequacy_of_city_street_lighting"                      ,                                           
                            "q9_09_accessibility_of_streets_sidewalks_and_buildings_for_people_with_disabilities" ,                   
                            "q9_10_on_street_bicycle_infrastructure_bike_lanes_wayfinding_signs"  ,                                   
                            
                            "q11_01_ride_kc_bus_system"   ,                                                                                          
                            "q11_02_kansas_city_streetcar" ,
                            
                            "q12_01_enforcing_the_clean_up_of_trash_and_debris_on_private_property"   ,                                                       
                            "q12_02_enforcing_the_mowing_and_cutting_of_weeds_on_private_property",                                                           
                            "q12_03_enforcing_the_exterior_maintenance_of_residential_property" ,                                  
                            "q12_04_enforcing_trash_weeds_and_exterior_maintenance_in_your_neighborhood"   ,                                                  
                            "q12_05_boarding_up_vacant_structures_that_are_open_to_entry"    ,                                                                
                            "q12_06_demolishing_vacant_structures_that_are_in_the_dangerous_building_inventory" ,                                             
                            "q12_07_enforcement_of_animal_code_e_g_animal_welfare_and_pet_licensing" ,                                                        
                            "q12_08_customer_service_from_kc_pet_project_staff"   ,                                                                           
                            "q12_09_animal_shelter_adoption_efforts_and_community_education_resources" ,                                                      
                            "q12_10_process_for_intake_of_animals_by_animal_control" ,
                            
                            
                            "q14_01_the_availability_of_affordable_housing_for_your_family"   ,                                                                     
                            "q14_02_the_quality_of_housing_for_your_family"    ,                                                                                    
                            "q14_03_legal_protections_including_fair_housing_and_eviction_prevention_for_renters"  ,                                                
                            "q14_04_support_services_for_unhoused_residents" ,
                            
                            "q15_01_ease_of_using_the_municipal_court_online_ticket_payment_and_information_system" ,                                       
                            "q15_02_effectiveness_of_problem_solving_court_programs"  ,         
                            "q15_03_courtesy_and_professionalism_of_municipal_court_staff"    ,                                                             
                            "q15_04_overall_ability_of_municipal_court_to_be_fair_and_impartial"  ,                                                         
                            "q15_05_availability_of_payment_plans_and_alternative_sentencing"   ,                   
                            
                            "q17_01_ease_of_utilizing_311_services_via_phone"    ,                                                                         
                            "q17_02_ease_of_utilizing_311_services_via_web_or_mobile_application"  ,                                                        
                            "q17_03_courtesy_and_professionalism_of_311_call_takers"    ,                                                                   
                            "q17_04_how_well_your_question_or_issue_was_resolved_via_311"   ,                                                               
                            
                            "q25_count_on_someone_in_the_community",
                            
                            "q26_01_had_personal_conversations_with_people_of_a_different_race_or_ethnicity_than_you"   ,                                                               
                            "q26_02_had_personal_conversations_with_people_who_have_different_political_views_than_you"  , 
                            
                            "q27_01_attended_any_public_meeting_in_which_there_was_discussion_of_local_government_affairs" ,                                                        
                            "q27_02_tried_to_get_your_local_government_to_pay_attention_to_something_that_concerned_you" ,                                                          
                            "q27_03_had_friends_of_another_race_over_to_your_home" ,
                            
                            "q28_self_reported_health"  ,                                                                                                                                                              
                            "q29_financial_situation"   ,                                                                                                                                            
                            "q30_standard_of_living_compared_to_parents",
                            
                            "q31_01_were_you_or_anyone_in_your_household_the_victim_of_any_crime_in_kansas_city_missouri_during_the_last_year"  ,                                                                                   
                            "q31_02_have_you_had_contact_with_a_kcpd_police_officer_during_the_last_year"        ,                                                                                                                  
                            "q31_03_have_any_members_of_your_household_used_the_kansas_city_missouri_ambulance_service_in_the_last_year"  ,                                                                                         
                            "q31_04_have_you_or_anyone_in_your_household_contacted_the_citys_311_call_center_in_the_last_year" ,                                                                                                    
                            "q31_05_have_you_visited_the_citys_website_kcmo_gov_in_the_last_year"    ,                                                                                                                              
                            "q31_06_have_you_used_the_bulky_item_pick_up_service_in_the_last_year"     ,                                                                                                                            
                            "q31_07_have_you_or_anyone_in_your_household_visited_a_kansas_city_missouri_community_center_in_the_last_year"  ,                                                                                       
                            "q31_08_have_any_members_of_your_household_visited_any_parks_in_kansas_city_missouri_in_the_last_year"  ,                                                                                               
                            "q31_09_have_you_used_the_ride_kc_bus_system_in_the_last_year"        ,                                                                                                                                 
                            "q31_10_have_you_used_the_kansas_city_streetcar_in_the_last_year"  ,                                                                                                                                    
                            "q31_11_do_you_have_regular_access_to_the_internet_at_home"      ,                                                                                                                                      
                            "q31_12_have_you_paid_a_municipal_court_ticket_online_in_the_last_year"   ,                                                                                                                             
                            "q31_13_have_you_visited_been_to_the_municipal_court_courthouse_in_the_last_year"   ,                                                                                                                   
                            "q31_14_have_you_flown_out_of_kansas_city_international_airport_in_the_last_year"  ,                                                                                                                    
                            "q31_15_have_you_contacted_kc_water_regarding_your_account_in_the_last_year" ,                                                                                                                          
                            "q31_16_have_you_ridden_a_bicycle_on_city_streets_or_trails_in_the_last_year"   ,                                                                                                                       
                            "q31_17_have_you_or_anyone_in_your_household_called_911_while_in_kansas_city_missouri_in_the_last_year" ,                                                                                              
                            "q31_18_do_you_have_children_under_the_age_of_18_living_in_your_household"  ,                                                                                                                           
                            "q31_19_do_you_own_a_small_business_or_are_you_self_employed"     ,                                                                                                                                       
                            "q31_20_have_you_been_worried_or_stressed_about_having_enough_money_to_pay_your_rent_mortgage_in_the_last_year",                                                                                        
                            "q31_21_have_you_attended_any_city_meetings"   ,                                                                                  
                            "q31_22_are_you_aware_of_the_kc_spirit_playbook_the_citys_initiative_to_update_its_comprehensive_plan"  ,
                            
                            "q32_01_job_opportunities_available_within_the_city_limits_of_kansas_city",                                                                                                                    
                            "q32_02_ability_to_obtain_training_opportunities_to_advance_your_career" ,                                                                                                                     
                            "q32_03_support_for_entrepreneurs_and_small_business_owners_available_in_kansas_city"   ,                                                                                                       
                            "q32_04_citys_use_of_economic_development_incentives_to_support_economic_opportunity_for_residents"  ,
                            
                            "q34_do_you_own_or_rent_your_current_residence"          ,                                                                                                                                                                                                                           
                            
                            "race",
                            
                            "q39_income"       ,                                                                                                                                                                                        
                            "q40_age"      ,                                                                                                                                                                                                                            
                            "q41_gender_identity"      ,                                                                                                                                                                                                                                      
                            "city"   ,                                                                                                                                                                                                                                               
                            "state" ,                                                                                                                                                                                                                                               
                            "council_district"   )
                        ),
                        status = "danger",
                        width = 6
                      ),
                      box(
                        selectInput(
                          "xcol",
                          "X Variables:",
                          c(
                            "method" ,   
                            
                            "q1_01_as_a_place_to_live" ,                                                                                                                                                     
                            "q1_02_as_a_place_to_raise_children"   ,                                                                                                                                         
                            "q1_03_as_a_place_to_work",      
                            
                            "q2_01_overall_quality_of_services_provided_by_the_city"  ,                                                      
                            "q2_02_overall_value_you_receive_for_your_city_tax_dollars_and_fees"    ,                                        
                            "q2_03_overall_image_of_the_city" ,                                                                              
                            "q2_04_overall_quality_of_life_in_the_city" ,                                                                    
                            "q2_05_overall_feeling_of_safety_in_the_city"  ,                                                                 
                            "q2_06_how_safe_you_feel_in_your_neighborhood"    ,                                                              
                            "q2_07_overall_quality_of_education_system_within_the_city" ,                                                    
                            "q2_08_physical_appearance_of_your_neighborhood",  
                            
                            "q3_01_police_services" ,                                                                           
                            "q3_02_fire_and_ambulance_services" ,                                                               
                            "q3_03_the_maintenance_of_city_streets_sidewalks_and_infrastructure" ,                              
                            "q3_04_solid_waste_services"  ,                         
                            "q3_05_city_water_utilities"  ,                                                                     
                            "q3_06_neighborhood_services"  ,          
                            "q3_07_city_parks_and_recreation_programs_facilities"  ,                                            
                            "q3_08_health_department_services",                                                                 
                            "q3_09_airport_facilities",                                                                         
                            "q3_10_the_citys_311_service",                                                                      
                            "q3_11_municipal_court_services" ,                                                                  
                            "q3_12_customer_service_you_receive_from_city_employees"  ,                                         
                            "q3_13_overall_effectiveness_of_city_communication_with_the_public" ,                               
                            "q3_14_the_citys_stormwater_runoff_stormwater_management_system",                                   
                            "q3_15_public_transportation"  ,                                                                    
                            "q3_16_city_planning_and_development_services"  ,                               
                            
                            "q5_01_effectiveness_of_local_police_protection",                                                                                       
                            "q5_02_the_relationship_between_my_neighborhood_and_the_police" ,                                                                        
                            "q5_03_the_citys_overall_efforts_to_prevent_crime" ,                                                                                     
                            "q5_04_enforcement_of_local_traffic_laws",                                                                                               
                            "q5_05_parking_enforcement_services",                                                                                                    
                            "q5_06_how_quickly_police_respond_to_emergencies"   ,                                                                                    
                            "q5_07_responsiveness_of_the_police_department_to_resident_concerns" ,                                                                   
                            
                            "q7_01_overall_quality_of_local_fire_protection_and_rescue_services"   ,                                             
                            "q7_02_how_quickly_fire_and_rescue_personnel_respond_to_emergencies" ,                                               
                            "q7_03_quality_of_local_emergency_medical_service"       ,                                                           
                            "q7_04_how_quickly_emergency_medical_personnel_respond_to_emergencies" ,
                            
                            "q9_01_maintenance_of_city_streets" ,                                                                     
                            "q9_02_maintenance_of_streets_in_your_neighborhood"   ,                                                   
                            "q9_03_condition_of_sidewalks_in_the_city",                                                               
                            "q9_04_condition_of_sidewalks_in_your_neighborhood" ,                                                     
                            "q9_05_maintenance_of_street_signs_and_traffic_signals",                                                  
                            "q9_06_snow_removal_on_major_city_streets_during_the_past_12_months"  ,                                   
                            "q9_07_snow_removal_on_residential_streets_during_the_past_12_months" ,                                   
                            "q9_08_adequacy_of_city_street_lighting"                      ,                                           
                            "q9_09_accessibility_of_streets_sidewalks_and_buildings_for_people_with_disabilities" ,                   
                            "q9_10_on_street_bicycle_infrastructure_bike_lanes_wayfinding_signs"  ,                                   
                            
                            "q11_01_ride_kc_bus_system"   ,                                                                                          
                            "q11_02_kansas_city_streetcar" ,
                            
                            "q12_01_enforcing_the_clean_up_of_trash_and_debris_on_private_property"   ,                                                       
                            "q12_02_enforcing_the_mowing_and_cutting_of_weeds_on_private_property",                                                           
                            "q12_03_enforcing_the_exterior_maintenance_of_residential_property" ,                                  
                            "q12_04_enforcing_trash_weeds_and_exterior_maintenance_in_your_neighborhood"   ,                                                  
                            "q12_05_boarding_up_vacant_structures_that_are_open_to_entry"    ,                                                                
                            "q12_06_demolishing_vacant_structures_that_are_in_the_dangerous_building_inventory" ,                                             
                            "q12_07_enforcement_of_animal_code_e_g_animal_welfare_and_pet_licensing" ,                                                        
                            "q12_08_customer_service_from_kc_pet_project_staff"   ,                                                                           
                            "q12_09_animal_shelter_adoption_efforts_and_community_education_resources" ,                                                      
                            "q12_10_process_for_intake_of_animals_by_animal_control" ,
                            
                            
                            "q14_01_the_availability_of_affordable_housing_for_your_family"   ,                                                                     
                            "q14_02_the_quality_of_housing_for_your_family"    ,                                                                                    
                            "q14_03_legal_protections_including_fair_housing_and_eviction_prevention_for_renters"  ,                                                
                            "q14_04_support_services_for_unhoused_residents" ,
                            
                            "q15_01_ease_of_using_the_municipal_court_online_ticket_payment_and_information_system" ,                                       
                            "q15_02_effectiveness_of_problem_solving_court_programs"  ,         
                            "q15_03_courtesy_and_professionalism_of_municipal_court_staff"    ,                                                             
                            "q15_04_overall_ability_of_municipal_court_to_be_fair_and_impartial"  ,                                                         
                            "q15_05_availability_of_payment_plans_and_alternative_sentencing"   ,                   
                            
                            "q17_01_ease_of_utilizing_311_services_via_phone"    ,                                                                         
                            "q17_02_ease_of_utilizing_311_services_via_web_or_mobile_application"  ,                                                        
                            "q17_03_courtesy_and_professionalism_of_311_call_takers"    ,                                                                   
                            "q17_04_how_well_your_question_or_issue_was_resolved_via_311"   ,                                                               
                            
                            "q25_count_on_someone_in_the_community",
                            
                            "q26_01_had_personal_conversations_with_people_of_a_different_race_or_ethnicity_than_you"   ,                                                               
                            "q26_02_had_personal_conversations_with_people_who_have_different_political_views_than_you"  , 
                            
                            "q27_01_attended_any_public_meeting_in_which_there_was_discussion_of_local_government_affairs" ,                                                        
                            "q27_02_tried_to_get_your_local_government_to_pay_attention_to_something_that_concerned_you" ,                                                          
                            "q27_03_had_friends_of_another_race_over_to_your_home" ,
                            
                            "q28_self_reported_health"  ,                                                                                                                                                              
                            "q29_financial_situation"   ,                                                                                                                                            
                            "q30_standard_of_living_compared_to_parents",
                            
                            "q31_01_were_you_or_anyone_in_your_household_the_victim_of_any_crime_in_kansas_city_missouri_during_the_last_year"  ,                                                                                   
                            "q31_02_have_you_had_contact_with_a_kcpd_police_officer_during_the_last_year"        ,                                                                                                                  
                            "q31_03_have_any_members_of_your_household_used_the_kansas_city_missouri_ambulance_service_in_the_last_year"  ,                                                                                         
                            "q31_04_have_you_or_anyone_in_your_household_contacted_the_citys_311_call_center_in_the_last_year" ,                                                                                                    
                            "q31_05_have_you_visited_the_citys_website_kcmo_gov_in_the_last_year"    ,                                                                                                                              
                            "q31_06_have_you_used_the_bulky_item_pick_up_service_in_the_last_year"     ,                                                                                                                            
                            "q31_07_have_you_or_anyone_in_your_household_visited_a_kansas_city_missouri_community_center_in_the_last_year"  ,                                                                                       
                            "q31_08_have_any_members_of_your_household_visited_any_parks_in_kansas_city_missouri_in_the_last_year"  ,                                                                                               
                            "q31_09_have_you_used_the_ride_kc_bus_system_in_the_last_year"        ,                                                                                                                                 
                            "q31_10_have_you_used_the_kansas_city_streetcar_in_the_last_year"  ,                                                                                                                                    
                            "q31_11_do_you_have_regular_access_to_the_internet_at_home"      ,                                                                                                                                      
                            "q31_12_have_you_paid_a_municipal_court_ticket_online_in_the_last_year"   ,                                                                                                                             
                            "q31_13_have_you_visited_been_to_the_municipal_court_courthouse_in_the_last_year"   ,                                                                                                                   
                            "q31_14_have_you_flown_out_of_kansas_city_international_airport_in_the_last_year"  ,                                                                                                                    
                            "q31_15_have_you_contacted_kc_water_regarding_your_account_in_the_last_year" ,                                                                                                                          
                            "q31_16_have_you_ridden_a_bicycle_on_city_streets_or_trails_in_the_last_year"   ,                                                                                                                       
                            "q31_17_have_you_or_anyone_in_your_household_called_911_while_in_kansas_city_missouri_in_the_last_year" ,                                                                                              
                            "q31_18_do_you_have_children_under_the_age_of_18_living_in_your_household"  ,                                                                                                                           
                            "q31_19_do_you_own_a_small_business_or_are_you_self_employed"     ,                                                                                                                                       
                            "q31_20_have_you_been_worried_or_stressed_about_having_enough_money_to_pay_your_rent_mortgage_in_the_last_year",                                                                                        
                            "q31_21_have_you_attended_any_city_meetings"   ,                                                                                  
                            "q31_22_are_you_aware_of_the_kc_spirit_playbook_the_citys_initiative_to_update_its_comprehensive_plan"  ,
                            
                            "q32_01_job_opportunities_available_within_the_city_limits_of_kansas_city",                                                                                                                    
                            "q32_02_ability_to_obtain_training_opportunities_to_advance_your_career" ,                                                                                                                     
                            "q32_03_support_for_entrepreneurs_and_small_business_owners_available_in_kansas_city"   ,                                                                                                       
                            "q32_04_citys_use_of_economic_development_incentives_to_support_economic_opportunity_for_residents"  ,
                            
                            "q34_do_you_own_or_rent_your_current_residence"          ,                                                                                                                                                                                                                           
                            
                            "race",
                            
                            "q39_income"       ,                                                                                                                                                                                        
                            "q40_age"      ,                                                                                                                                                                                                                            
                            "q41_gender_identity"      ,                                                                                                                                                                                                                                      
                            "city"   ,                                                                                                                                                                                                                                               
                            "state" ,                                                                                                                                                                                                                                               
                            "council_district"   )
                        ),
                        status = "primary",
                        width = 6
                      ),
                    ),

                    fluidRow(
                      box(
                        id = "mosaic_container",
                        plotOutput("Mosaic", height = 500),
                        width = 6,
                        downloadButton("downloadMosaic", "Download Mosaic")
                      ),
                      box(
                        id = "plotx_container",
                        plotOutput("PlotXtabs", height = 500),
                        width = 6
                      ),
                      #can not figure out how to download this with a button like above.
                    ),
                    fluidRow(
                      box(
                        id = "table_container",
                        title = "Cramer's V by Y Variable",
                        dataTableOutput("table"),
                        width = 6
                      ),
                      box(
                        id = "simpley_container",
                        title = ,
                        plotOutput("simpley"),
                        width = 3
                      ),
                      box(
                        id = "simplex_container",
                        title = ,
                        plotOutput("simplex"),
                        width = 3
                      )
                    )
                  ),
                  ### MAR 2022 ------------------------------------
                  tabItem(
                    "Resident_Survey_2022",
                    fluidRow(box(
                      width = 12,
                      div(style = "height: 50px; font-size: 40px;",
                          "March 2022 Resident Survey Dashboard"))
                    ),
                    fluidRow(box(width = 12,
                                 p(style = "height: 10px; font-size: 12px;",
                                   "Select two variables from the drop boxes on the left."),
                                 p(style = "height: 10px; font-size: 12px;",
                                   "Chi-Squared and other statistic of the two variables is shown below."),
                                 p(style = "height: 30px; font-size: 12px;",
                                   "Cramer's V is a number between 0 and 1. The closer the Cramer's V is to 1, the stronger the relationship is between the two variables. Scores above .10 are weakly associated. Scores above .4 are strongly related."),
                                 p(style = "height: 10px; font-size: 12px;",
                                                         "P-values should be smaller than .02 to be statistically significant."))
                    ),
                    fluidRow(
                      box(
                        selectInput(
                          "ycol2",
                          "Y Variables:",
                          c(
                            "method" ,   
                            
                            "q1_01_as_a_place_to_live" ,                                                                                                                                                     
                            "q1_02_as_a_place_to_raise_children"   ,                                                                                                                                         
                            "q1_03_as_a_place_to_work",      
                            
                            "q2_01_overall_quality_of_services_provided_by_the_city"  ,                                                      
                            "q2_02_overall_value_you_receive_for_your_city_tax_dollars_and_fees"    ,                                        
                            "q2_03_overall_image_of_the_city" ,                                                                              
                            "q2_04_overall_quality_of_life_in_the_city" ,                                                                    
                            "q2_05_overall_feeling_of_safety_in_the_city"  ,                                                                 
                            "q2_06_how_safe_you_feel_in_your_neighborhood"    ,                                                              
                            "q2_07_overall_quality_of_education_system_within_the_city" ,                                                    
                            "q2_08_physical_appearance_of_your_neighborhood",  
                            
                            "q3_01_police_services" ,                                                                           
                            "q3_02_fire_and_ambulance_services" ,                                                               
                            "q3_03_the_maintenance_of_city_streets_sidewalks_and_infrastructure" ,                              
                            "q3_04_solid_waste_services"  ,                         
                            "q3_05_city_water_utilities"  ,                                                                     
                            "q3_06_neighborhood_services"  ,          
                            "q3_07_city_parks_and_recreation_programs_facilities"  ,                                            
                            "q3_08_health_department_services",                                                                 
                            "q3_09_airport_facilities",                                                                         
                            "q3_10_the_citys_311_service",                                                                      
                            "q3_11_municipal_court_services" ,                                                                  
                            "q3_12_customer_service_you_receive_from_city_employees"  ,                                         
                            "q3_13_overall_effectiveness_of_city_communication_with_the_public" ,                               
                            "q3_14_the_citys_stormwater_runoff_stormwater_management_system",                                   
                            "q3_15_public_transportation"  ,                                                                    
                            "q3_16_city_planning_and_development_services"  ,                               
                            
                            "q5_01_effectiveness_of_local_police_protection",                                                                                       
                            "q5_02_the_relationship_between_my_neighborhood_and_the_police" ,                                                                        
                            "q5_03_the_citys_overall_efforts_to_prevent_crime" ,                                                                                     
                            "q5_04_enforcement_of_local_traffic_laws",                                                                                               
                            "q5_05_parking_enforcement_services",                                                                                                    
                            "q5_06_how_quickly_police_respond_to_emergencies"   ,                                                                                    
                            "q5_07_responsiveness_of_the_police_department_to_resident_concerns" ,                                                                   
                            
                            "q7_01_overall_quality_of_local_fire_protection_and_rescue_services"   ,                                             
                            "q7_02_how_quickly_fire_and_rescue_personnel_respond_to_emergencies" ,                                               
                            "q7_03_quality_of_local_emergency_medical_service"       ,                                                           
                            "q7_04_how_quickly_emergency_medical_personnel_respond_to_emergencies" ,
                            
                            "q9_01_maintenance_of_city_streets" ,                                                                     
                            "q9_02_maintenance_of_streets_in_your_neighborhood"   ,                                                   
                            "q9_03_condition_of_sidewalks_in_the_city",                                                               
                            "q9_04_condition_of_sidewalks_in_your_neighborhood" ,                                                     
                            "q9_05_maintenance_of_street_signs_and_traffic_signals",                                                  
                            "q9_06_snow_removal_on_major_city_streets_during_the_past_12_months"  ,                                   
                            "q9_07_snow_removal_on_residential_streets_during_the_past_12_months" ,                                   
                            "q9_08_adequacy_of_city_street_lighting"                      ,                                           
                            "q9_09_accessibility_of_streets_sidewalks_and_buildings_for_people_with_disabilities" ,                   
                            "q9_10_on_street_bicycle_infrastructure_bike_lanes_wayfinding_signs"  ,                                   
                            
                            "q11_01_ride_kc_bus_system"   ,                                                                                          
                            "q11_02_kansas_city_streetcar" ,
                            
                            "q12_01_enforcing_the_clean_up_of_trash_and_debris_on_private_property"   ,                                                       
                            "q12_02_enforcing_the_mowing_and_cutting_of_weeds_on_private_property",                                                           
                            "q12_03_enforcing_the_exterior_maintenance_of_residential_property" ,                                  
                            "q12_04_enforcing_trash_weeds_and_exterior_maintenance_in_your_neighborhood"   ,                                                  
                            "q12_05_boarding_up_vacant_structures_that_are_open_to_entry"    ,                                                                
                            "q12_06_demolishing_vacant_structures_that_are_in_the_dangerous_building_inventory" ,                                             
                            "q12_07_enforcement_of_animal_code_e_g_animal_welfare_and_pet_licensing" ,                                                        
                            "q12_08_customer_service_from_kc_pet_project_staff"   ,                                                                           
                            "q12_09_animal_shelter_adoption_efforts_and_community_education_resources" ,                                                      
                            "q12_10_process_for_intake_of_animals_by_animal_control" ,
                            
                            
                            "q14_01_the_availability_of_affordable_housing_for_your_family"   ,                                                                     
                            "q14_02_the_quality_of_housing_for_your_family"    ,                                                                                    
                            "q14_03_legal_protections_including_fair_housing_and_eviction_prevention_for_renters"  ,                                                
                            "q14_04_support_services_for_unhoused_residents" ,
                            
                            "q15_01_ease_of_using_the_municipal_court_online_ticket_payment_and_information_system" ,                                       
                            "q15_02_effectiveness_of_problem_solving_court_programs"  ,         
                            "q15_03_courtesy_and_professionalism_of_municipal_court_staff"    ,                                                             
                            "q15_04_overall_ability_of_municipal_court_to_be_fair_and_impartial"  ,                                                         
                            "q15_05_availability_of_payment_plans_and_alternative_sentencing"   ,                   
                            
                            "q17_01_ease_of_utilizing_311_services_via_phone"    ,                                                                         
                            "q17_02_ease_of_utilizing_311_services_via_web_or_mobile_application"  ,                                                        
                            "q17_03_courtesy_and_professionalism_of_311_call_takers"    ,                                                                   
                            "q17_04_how_well_your_question_or_issue_was_resolved_via_311"   ,                                                               
                            
                            "q25_count_on_someone_in_the_community",
                            
                            "q26_01_had_personal_conversations_with_people_of_a_different_race_or_ethnicity_than_you"   ,                                                               
                            "q26_02_had_personal_conversations_with_people_who_have_different_political_views_than_you"  , 
                            
                            "q27_01_attended_any_public_meeting_in_which_there_was_discussion_of_local_government_affairs" ,                                                        
                            "q27_02_tried_to_get_your_local_government_to_pay_attention_to_something_that_concerned_you" ,                                                          
                            "q27_03_had_friends_of_another_race_over_to_your_home" ,
                            
                            "q28_self_reported_health"  ,                                                                                                                                                              
                            "q29_financial_situation"   ,                                                                                                                                            
                            "q30_standard_of_living_compared_to_parents",
                            
                            "q31_01_were_you_or_anyone_in_your_household_the_victim_of_any_crime_in_kansas_city_missouri_during_the_last_year"  ,                                                                                   
                            "q31_02_have_you_had_contact_with_a_kcpd_police_officer_during_the_last_year"        ,                                                                                                                  
                            "q31_03_have_any_members_of_your_household_used_the_kansas_city_missouri_ambulance_service_in_the_last_year"  ,                                                                                         
                            "q31_04_have_you_or_anyone_in_your_household_contacted_the_citys_311_call_center_in_the_last_year" ,                                                                                                    
                            "q31_05_have_you_visited_the_citys_website_kcmo_gov_in_the_last_year"    ,                                                                                                                              
                            "q31_06_have_you_used_the_bulky_item_pick_up_service_in_the_last_year"     ,                                                                                                                            
                            "q31_07_have_you_or_anyone_in_your_household_visited_a_kansas_city_missouri_community_center_in_the_last_year"  ,                                                                                       
                            "q31_08_have_any_members_of_your_household_visited_any_parks_in_kansas_city_missouri_in_the_last_year"  ,                                                                                               
                            "q31_09_have_you_used_the_ride_kc_bus_system_in_the_last_year"        ,                                                                                                                                 
                            "q31_10_have_you_used_the_kansas_city_streetcar_in_the_last_year"  ,                                                                                                                                    
                            "q31_11_do_you_have_regular_access_to_the_internet_at_home"      ,                                                                                                                                      
                            "q31_12_have_you_paid_a_municipal_court_ticket_online_in_the_last_year"   ,                                                                                                                             
                            "q31_13_have_you_visited_been_to_the_municipal_court_courthouse_in_the_last_year"   ,                                                                                                                   
                            "q31_14_have_you_flown_out_of_kansas_city_international_airport_in_the_last_year"  ,                                                                                                                    
                            "q31_15_have_you_contacted_kc_water_regarding_your_account_in_the_last_year" ,                                                                                                                          
                            "q31_16_have_you_ridden_a_bicycle_on_city_streets_or_trails_in_the_last_year"   ,                                                                                                                       
                            "q31_17_have_you_or_anyone_in_your_household_called_911_while_in_kansas_city_missouri_in_the_last_year" ,                                                                                              
                            "q31_18_do_you_have_children_under_the_age_of_18_living_in_your_household"  ,                                                                                                                           
                            "q31_19_do_you_own_a_small_business_or_are_you_self_employed"     ,                                                                                                                                       
                            "q31_20_have_you_been_worried_or_stressed_about_having_enough_money_to_pay_your_rent_mortgage_in_the_last_year",                                                                                        
                            "q31_21_have_you_attended_any_city_meetings"   ,                                                                                  
                            "q31_22_are_you_aware_of_the_kc_spirit_playbook_the_citys_initiative_to_update_its_comprehensive_plan"  ,
                            
                            "q32_01_job_opportunities_available_within_the_city_limits_of_kansas_city",                                                                                                                    
                            "q32_02_ability_to_obtain_training_opportunities_to_advance_your_career" ,                                                                                                                     
                            "q32_03_support_for_entrepreneurs_and_small_business_owners_available_in_kansas_city"   ,                                                                                                       
                            "q32_04_citys_use_of_economic_development_incentives_to_support_economic_opportunity_for_residents"  ,
                            
                            "q34_do_you_own_or_rent_your_current_residence"          ,                                                                                                                                                                                                                           
                            
                            "race",
                            
                            "q39_income"       ,                                                                                                                                                                                        
                            "q40_age"      ,                                                                                                                                                                                                                            
                            "q41_gender_identity"      ,                                                                                                                                                                                                                                      
                            "city"   ,                                                                                                                                                                                                                                               
                            "state" ,                                                                                                                                                                                                                                               
                            "council_district"   )
                        ),
                        status = "danger",
                        width = 6
                      ),
                      box(
                        selectInput(
                          "xcol2",
                          "X Variables:",
                          c(
                            "method" ,   
                            
                            "q1_01_as_a_place_to_live" ,                                                                                                                                                     
                            "q1_02_as_a_place_to_raise_children"   ,                                                                                                                                         
                            "q1_03_as_a_place_to_work",      
                            
                            "q2_01_overall_quality_of_services_provided_by_the_city"  ,                                                      
                            "q2_02_overall_value_you_receive_for_your_city_tax_dollars_and_fees"    ,                                        
                            "q2_03_overall_image_of_the_city" ,                                                                              
                            "q2_04_overall_quality_of_life_in_the_city" ,                                                                    
                            "q2_05_overall_feeling_of_safety_in_the_city"  ,                                                                 
                            "q2_06_how_safe_you_feel_in_your_neighborhood"    ,                                                              
                            "q2_07_overall_quality_of_education_system_within_the_city" ,                                                    
                            "q2_08_physical_appearance_of_your_neighborhood",  
                            
                            "q3_01_police_services" ,                                                                           
                            "q3_02_fire_and_ambulance_services" ,                                                               
                            "q3_03_the_maintenance_of_city_streets_sidewalks_and_infrastructure" ,                              
                            "q3_04_solid_waste_services"  ,                         
                            "q3_05_city_water_utilities"  ,                                                                     
                            "q3_06_neighborhood_services"  ,          
                            "q3_07_city_parks_and_recreation_programs_facilities"  ,                                            
                            "q3_08_health_department_services",                                                                 
                            "q3_09_airport_facilities",                                                                         
                            "q3_10_the_citys_311_service",                                                                      
                            "q3_11_municipal_court_services" ,                                                                  
                            "q3_12_customer_service_you_receive_from_city_employees"  ,                                         
                            "q3_13_overall_effectiveness_of_city_communication_with_the_public" ,                               
                            "q3_14_the_citys_stormwater_runoff_stormwater_management_system",                                   
                            "q3_15_public_transportation"  ,                                                                    
                            "q3_16_city_planning_and_development_services"  ,                               
                            
                            "q5_01_effectiveness_of_local_police_protection",                                                                                       
                            "q5_02_the_relationship_between_my_neighborhood_and_the_police" ,                                                                        
                            "q5_03_the_citys_overall_efforts_to_prevent_crime" ,                                                                                     
                            "q5_04_enforcement_of_local_traffic_laws",                                                                                               
                            "q5_05_parking_enforcement_services",                                                                                                    
                            "q5_06_how_quickly_police_respond_to_emergencies"   ,                                                                                    
                            "q5_07_responsiveness_of_the_police_department_to_resident_concerns" ,                                                                   
                            
                            "q7_01_overall_quality_of_local_fire_protection_and_rescue_services"   ,                                             
                            "q7_02_how_quickly_fire_and_rescue_personnel_respond_to_emergencies" ,                                               
                            "q7_03_quality_of_local_emergency_medical_service"       ,                                                           
                            "q7_04_how_quickly_emergency_medical_personnel_respond_to_emergencies" ,
                            
                            "q9_01_maintenance_of_city_streets" ,                                                                     
                            "q9_02_maintenance_of_streets_in_your_neighborhood"   ,                                                   
                            "q9_03_condition_of_sidewalks_in_the_city",                                                               
                            "q9_04_condition_of_sidewalks_in_your_neighborhood" ,                                                     
                            "q9_05_maintenance_of_street_signs_and_traffic_signals",                                                  
                            "q9_06_snow_removal_on_major_city_streets_during_the_past_12_months"  ,                                   
                            "q9_07_snow_removal_on_residential_streets_during_the_past_12_months" ,                                   
                            "q9_08_adequacy_of_city_street_lighting"                      ,                                           
                            "q9_09_accessibility_of_streets_sidewalks_and_buildings_for_people_with_disabilities" ,                   
                            "q9_10_on_street_bicycle_infrastructure_bike_lanes_wayfinding_signs"  ,                                   
                            
                            "q11_01_ride_kc_bus_system"   ,                                                                                          
                            "q11_02_kansas_city_streetcar" ,
                            
                            "q12_01_enforcing_the_clean_up_of_trash_and_debris_on_private_property"   ,                                                       
                            "q12_02_enforcing_the_mowing_and_cutting_of_weeds_on_private_property",                                                           
                            "q12_03_enforcing_the_exterior_maintenance_of_residential_property" ,                                  
                            "q12_04_enforcing_trash_weeds_and_exterior_maintenance_in_your_neighborhood"   ,                                                  
                            "q12_05_boarding_up_vacant_structures_that_are_open_to_entry"    ,                                                                
                            "q12_06_demolishing_vacant_structures_that_are_in_the_dangerous_building_inventory" ,                                             
                            "q12_07_enforcement_of_animal_code_e_g_animal_welfare_and_pet_licensing" ,                                                        
                            "q12_08_customer_service_from_kc_pet_project_staff"   ,                                                                           
                            "q12_09_animal_shelter_adoption_efforts_and_community_education_resources" ,                                                      
                            "q12_10_process_for_intake_of_animals_by_animal_control" ,
                            
                            
                            "q14_01_the_availability_of_affordable_housing_for_your_family"   ,                                                                     
                            "q14_02_the_quality_of_housing_for_your_family"    ,                                                                                    
                            "q14_03_legal_protections_including_fair_housing_and_eviction_prevention_for_renters"  ,                                                
                            "q14_04_support_services_for_unhoused_residents" ,
                            
                            "q15_01_ease_of_using_the_municipal_court_online_ticket_payment_and_information_system" ,                                       
                            "q15_02_effectiveness_of_problem_solving_court_programs"  ,         
                            "q15_03_courtesy_and_professionalism_of_municipal_court_staff"    ,                                                             
                            "q15_04_overall_ability_of_municipal_court_to_be_fair_and_impartial"  ,                                                         
                            "q15_05_availability_of_payment_plans_and_alternative_sentencing"   ,                   
                            
                            "q17_01_ease_of_utilizing_311_services_via_phone"    ,                                                                         
                            "q17_02_ease_of_utilizing_311_services_via_web_or_mobile_application"  ,                                                        
                            "q17_03_courtesy_and_professionalism_of_311_call_takers"    ,                                                                   
                            "q17_04_how_well_your_question_or_issue_was_resolved_via_311"   ,                                                               
                            
                            "q25_count_on_someone_in_the_community",
                            
                            "q26_01_had_personal_conversations_with_people_of_a_different_race_or_ethnicity_than_you"   ,                                                               
                            "q26_02_had_personal_conversations_with_people_who_have_different_political_views_than_you"  , 
                            
                            "q27_01_attended_any_public_meeting_in_which_there_was_discussion_of_local_government_affairs" ,                                                        
                            "q27_02_tried_to_get_your_local_government_to_pay_attention_to_something_that_concerned_you" ,                                                          
                            "q27_03_had_friends_of_another_race_over_to_your_home" ,
                            
                            "q28_self_reported_health"  ,                                                                                                                                                              
                            "q29_financial_situation"   ,                                                                                                                                            
                            "q30_standard_of_living_compared_to_parents",
                            
                            "q31_01_were_you_or_anyone_in_your_household_the_victim_of_any_crime_in_kansas_city_missouri_during_the_last_year"  ,                                                                                   
                            "q31_02_have_you_had_contact_with_a_kcpd_police_officer_during_the_last_year"        ,                                                                                                                  
                            "q31_03_have_any_members_of_your_household_used_the_kansas_city_missouri_ambulance_service_in_the_last_year"  ,                                                                                         
                            "q31_04_have_you_or_anyone_in_your_household_contacted_the_citys_311_call_center_in_the_last_year" ,                                                                                                    
                            "q31_05_have_you_visited_the_citys_website_kcmo_gov_in_the_last_year"    ,                                                                                                                              
                            "q31_06_have_you_used_the_bulky_item_pick_up_service_in_the_last_year"     ,                                                                                                                            
                            "q31_07_have_you_or_anyone_in_your_household_visited_a_kansas_city_missouri_community_center_in_the_last_year"  ,                                                                                       
                            "q31_08_have_any_members_of_your_household_visited_any_parks_in_kansas_city_missouri_in_the_last_year"  ,                                                                                               
                            "q31_09_have_you_used_the_ride_kc_bus_system_in_the_last_year"        ,                                                                                                                                 
                            "q31_10_have_you_used_the_kansas_city_streetcar_in_the_last_year"  ,                                                                                                                                    
                            "q31_11_do_you_have_regular_access_to_the_internet_at_home"      ,                                                                                                                                      
                            "q31_12_have_you_paid_a_municipal_court_ticket_online_in_the_last_year"   ,                                                                                                                             
                            "q31_13_have_you_visited_been_to_the_municipal_court_courthouse_in_the_last_year"   ,                                                                                                                   
                            "q31_14_have_you_flown_out_of_kansas_city_international_airport_in_the_last_year"  ,                                                                                                                    
                            "q31_15_have_you_contacted_kc_water_regarding_your_account_in_the_last_year" ,                                                                                                                          
                            "q31_16_have_you_ridden_a_bicycle_on_city_streets_or_trails_in_the_last_year"   ,                                                                                                                       
                            "q31_17_have_you_or_anyone_in_your_household_called_911_while_in_kansas_city_missouri_in_the_last_year" ,                                                                                              
                            "q31_18_do_you_have_children_under_the_age_of_18_living_in_your_household"  ,                                                                                                                           
                            "q31_19_do_you_own_a_small_business_or_are_you_self_employed"     ,                                                                                                                                       
                            "q31_20_have_you_been_worried_or_stressed_about_having_enough_money_to_pay_your_rent_mortgage_in_the_last_year",                                                                                        
                            "q31_21_have_you_attended_any_city_meetings"   ,                                                                                  
                            "q31_22_are_you_aware_of_the_kc_spirit_playbook_the_citys_initiative_to_update_its_comprehensive_plan"  ,
                            
                            "q32_01_job_opportunities_available_within_the_city_limits_of_kansas_city",                                                                                                                    
                            "q32_02_ability_to_obtain_training_opportunities_to_advance_your_career" ,                                                                                                                     
                            "q32_03_support_for_entrepreneurs_and_small_business_owners_available_in_kansas_city"   ,                                                                                                       
                            "q32_04_citys_use_of_economic_development_incentives_to_support_economic_opportunity_for_residents"  ,
                            
                            "q34_do_you_own_or_rent_your_current_residence"          ,                                                                                                                                                                                                                           
                            
                            "race",
                            
                            "q39_income"       ,                                                                                                                                                                                        
                            "q40_age"      ,                                                                                                                                                                                                                            
                            "q41_gender_identity"      ,                                                                                                                                                                                                                                      
                            "city"   ,                                                                                                                                                                                                                                               
                            "state" ,                                                                                                                                                                                                                                               
                            "council_district"   )
                        ),
                        status = "primary",
                        width = 6
                      ),
                    ),
                    fluidRow(
                      box(
                        id = "mosaic_container_2",
                        plotOutput("Mosaic_2", height = 500),
                        width = 6,
                        downloadButton("downloadMosaic_2", "Download Mosaic")
                      ),
                      box(
                        id = "plotx_container_2",
                        plotOutput("PlotXtabs_2", height = 500),
                        width = 6
                      ),
                      #can not figure out how to download this with a button like above.
                    ),
                    fluidRow(
                      box(
                        id = "table_container_2",
                        title = "Cramer's V by Y Variable",
                        dataTableOutput("table_2"),
                        width = 6
                      ),
                      box(
                        id = "simpley_container_2",
                        title = ,
                        plotOutput("simpley_2"),
                        width = 3
                      ),
                      box(
                        id = "simplex_container_2",
                        title = ,
                        plotOutput("simplex_2"),
                        width = 3
                      )
                    )
                  )
                  ### MAR 2021 ---------------------------------------------------
                  
                ))
)
