from fastapi import FastAPI
from database import Base,Column,String,Integer,engine,session,Year,Month,CalendarEvent
from pydantic import StrictStr, StrictInt,BaseModel,Field
from sqlalchemy import and_,or_
from typing import Optional
from datetime import date

app = FastAPI()

@app.get("/favicon.ico")
async def favicon():
    return {
        "msg":"tori"
   }

def get_today_date():
    current_date = date.today()
    #current_date = date(2019,5,14)
    reference_date = date(1935,4,13) #Baisakh 1 - Friday reference
    delta = current_date-reference_date
    month_days = session.query(Month.days,Year.name).join(Year,Year.id==Month.year_id).filter(Year.name>=1992) #get all months details
    remaining_days = delta.days+1
    
    traverse_year = 1992
    traverse_month = 0 
    last_days = 0
     
    for days,year in month_days:
        if remaining_days>=days:
            last_days = days
            remaining_days -= days
            traverse_month += 1
            if traverse_month>11:
                traverse_month = 0
                traverse_year += 1

    if remaining_days == 0:
        traverse_month -= 1
        remaining_days = last_days        

                
    # return (traverse_year,traverse_month,remaining_days)
    # return {
    #     "year":traverse_year,
    #     "month":traverse_month,
    #     "day":remaining_days
    # }
    return (traverse_year,traverse_month,remaining_days)
    
@app.get("/{year}/{month}")
async def get_year_info(year:int,month:int):
    y = 0
    m = 0
    d = 0
    current_year,current_month,current_days = get_today_date()

    if year==0:
        y,m,d = current_year,current_month,current_days
        year = y
    else:
        y = year
        m = month
    
    start_year = y
    end_year = y
    start_month = m-6
    end_month = m+5
    if start_month<0:
        start_month += 12
        start_year -= 1
    
    if end_month>11:
        end_month -= 12
        end_year += 1

    print("start year",start_year)
    print("end year",end_year)
    print("start month",start_month)
    print("end month",end_month)

    
    # response = session.query(Month.days,Year.name).join(Year,Year.id==Month.year_id).filter(Year.name.between(1992,year-1))
    response = session.query(Month.days,Year.name).join(Year,Year.id==Month.year_id).filter(
                            and_(Year.name.between(1992,start_year)),or_(Month.name<start_month,Year.name<start_year))
    current_year_days = session.query(Month.days).join(Year,Year.id==Month.year_id).filter(Year.name==year)
    current_query_days = session.query(Month.days,Month.name,Year.name).join(Year,Year.id==Month.year_id).filter(
                                         and_(Year.name.between(start_year,end_year),
                                              or_(and_(Month.name>=start_month, Year.name==start_year),and_(Month.name<=end_month,Year.name==end_year))))
    
    event_query = session.query(Year.name,Month.name,CalendarEvent.day,CalendarEvent.tithi,CalendarEvent.holiday
                                ).join(
                                  Year,Year.id==CalendarEvent.year_id
                                ).join(
                                  Month,Month.id==CalendarEvent.month_id
                                ).filter(
                                  and_(
                                    Year.name.between(start_year,end_year),
                                    or_(
                                      and_(
                                        Month.name>=start_month,
                                        Year.name==start_year
                                        ),
                                      and_(
                                        Month.name<=end_month,
                                        Year.name==end_year
                                        )
                                      )
                                    )
                                )

    print(event_query.all())
    event_json = {}
    event_json[0] = []
    event_json[1] = []
    event_json[2] = []
    event_json[3] = []
    event_json[4] = []
    event_json[5] = []
    event_json[6] = []
    event_json[7] = []
    event_json[8] = []
    event_json[9] = []
    event_json[10] = []
    event_json[11] = []

    indexing = {}
    event_index = 0
    

    for eyear,emonth,eday,etithi,eholiday in event_query:
        if indexing.get(emonth) is None:
          indexing[emonth] = event_index
          event_index += 1

        event_json[emonth].append({"day":eday,"holiday":eholiday,"tithi":etithi})

    for key,value in indexing.items():
      print(key,value) 
    
    new_json = {}
    for i in range(12):
      new_json[i] = []
      
    for key,value in indexing.items():
      new_json[value] = event_json[key]

    index = 0
    month_days_json = {}
    year_json = {}
    month_json = {}
    for (days,month,year_name) in current_query_days:
        month_days_json[index] = days
        year_json[index] = year_name
        month_json[index] = month
        index += 1
    
    # index = 0
    # month_days_json = {}
    # for (days,) in current_year_days:
    #     month_days_json[index]=days
    #     index += 1
        
    total_days = 0 
    for month_days,year_number in response:
        total_days += month_days

    day_index = (total_days+6)%7    
     
    return {
        "start":day_index,
        "month_days":month_days_json,
        "months":month_json,
        "years":year_json,
        "year":current_year,
        "month":current_month,
        "day":current_days,
        # "events":event_json
        "events":new_json
    }

# class BaseModelDays(BaseModel):
#     sy : Optional[StrictStr]=Field(type=)
#     sx : Optional[StrictStr]
    
# @app.get("/syau/{sy}/{sx}")
# async def tori(body: BaseModelDays):
#     return {
#         "sx":body.sx,
#         "sy" :body.sy
#     }
    
@app.get("/days/{sy}/{sm}/{sd}/{ey}/{em}/{ed}")
async def get_total_days(sy:int,sm:int,sd:int,ey:int,em:int,ed:int):
    print("I am here.................................",sy)
    return {
        "days":0,
        "success":True
    }


@app.get("/")
async def root():
    return {
  "day": 1,
  "month":5,
  "year":2080,
  "calendar":[
    {
      "year":2080,
      "months":[
        {
          "name":"Baisakh",
          "start_day":4,
          "days":29,
          "events":[
            {
              "detail":{
                "day":2,
                "is_holiday":True,
                "events":[
                  {
                    "name":"Dashain"
                  },
                  {
                    "name":"Nawami"
                  }
                ]
              }
            }
          ]
        },
        {
          "name":"Jestha",
          "start_day":6,
          "days":30,
          "events":[
            {
              "detail":{
                "day":5,
                "events":[
                  {
                    "name":"Holi"
                  },
                  {
                    "name":"Mahashivratri"
                  }
                ]
              }
            }
          ]
            
        }
      ]
    },
    {
      "year":2081,
      "months":[
        {
          "name":"Baisakh",
          "start_day":4,
          "days":29,
          "events":[
            {
              "detail":{
                "day":2,
                "events":[
                  {
                    "name":"Dashain"
                  },
                  {
                    "name":"Nawami"
                  }
                ]
              }
            }
          ]
        },
        {
          "name":"Jestha",
          "start_day":6,
          "days":30,
          "events":[
            {
              "detail":{
                "day":5,
                "events":[
                  {
                    "name":"Holi"
                  },
                  {
                    "name":"Mahashivratri"
                  }
                ]
              }
            }
          ]
            
        }
      ]
    }
  ]
}
 