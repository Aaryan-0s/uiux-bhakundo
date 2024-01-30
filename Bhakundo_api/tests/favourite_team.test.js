const supertest = require("supertest");

const app = require("../app");

const api = supertest(app);

const User = require("../models/user");
const favourite_team = require("../models/favourite");

const mongoose = require("mongoose");
let token = "";


beforeAll(async () => {
    await User.deleteMany();
   await favourite_team.deleteMany();
    await api.post("/api/v1/auth/signup").send({
        fname: "test",
      lname: "USer",
      username: "testUser",
      password: "test123",
      image:"profile.png",
      email: "test2@gmail.com",
        
      });
    
      const res = await api.post("/api/v1/auth/login").send({
        username: "testUser",
        password: "test123",
});
     token=res.body.token   });


  test("favourite team add", async () => {
    let teamId="101"
    const res = await api
      .post(`/api/v1/teams/favourites/add`
      )
      .set("Authorization", `Bearer ${token}`)
      .send({
        teamId:teamId,
        teamName:"test team",
        logoUrl:"test logo"
      })
      .expect(200);
      
    expect(res.body.data[0].teamName).toBe("test team");
  });
  test("favourite team get", async () => {
    let teamId="101"
    const res = await api
      .get(`/api/v1/teams/favourites/${teamId}`
      )
      .set("Authorization", `Bearer ${token}`)
      
      .expect(200);
      
    expect(res.body.data.teamName).toBe("test team");
  });
  test("favourite team all get", async () => {
    let teamId="101"
    const res = await api
      .get(`/api/v1/teams/favourites`
      )
      .set("Authorization", `Bearer ${token}`)
      
      .expect(200);
      
    expect(res.body.data[0].teamName).toBe("test team");
  });

  test("favourite team delete", async () => {
    let teamId="101"
    const res = await api
      .delete(`/api/v1/teams/unfavourite/${teamId}`
      )
      .set("Authorization", `Bearer ${token}`)
      
      .expect(200);
      
    expect(res.body.message).toBe("deleted");
  });

  
  
  
  
