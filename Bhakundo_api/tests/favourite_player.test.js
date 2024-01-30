const supertest = require("supertest");

const app = require("../app");

const api = supertest(app);

const User = require("../models/user");
const favourite_player = require("../models/favourite_player");

const mongoose = require("mongoose");
let token = "";


beforeAll(async () => {
    await User.deleteMany();
   await favourite_player.deleteMany();
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


  test("favourite player player add", async () => {
    let playerId="101"
    const res = await api
      .post(`/api/v1/players/favourites/player/add`
      )
      .set("Authorization", `Bearer ${token}`)
      .send({
        playerId:playerId,
        playerName:"test player",
        photoUrl:"test logo"
      })
      .expect(200);
      
    expect(res.body.data[0].playerName).toBe("test player");
  });
  test("favourite player get", async () => {
    let playerId="101"
    const res = await api
      .get(`/api/v1/players/favourites/player/${playerId}`
      )
      .set("Authorization", `Bearer ${token}`)
      
      .expect(200);
      
    expect(res.body.data.playerName).toBe("test player");
  });
  test("favourite player all get", async () => {
    let playerId="101"
    const res = await api
      .get(`/api/v1/players/favourites/player`
      )
      .set("Authorization", `Bearer ${token}`)
      
      .expect(200);
      
    expect(res.body.data[0].playerName).toBe("test player");
  });

  test("favourite player delete", async () => {
    let playerId="101"
    const res = await api
      .delete(`/api/v1/players/unfavourite/player/${playerId}`
      )
      .set("Authorization", `Bearer ${token}`)
      
      .expect(200);
      
    expect(res.body.message).toBe("deleted");
  });

  
  
  
  
