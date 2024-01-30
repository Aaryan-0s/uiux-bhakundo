const supertest = require("supertest");

const app = require("../app");

const api = supertest(app);

const User = require("../models/user");
const Comment = require("../models/comment");

const mongoose = require("mongoose");
let token = "";


beforeAll(async () => {
  await User.deleteMany();
  await Comment.deleteMany();
  await api.post("/api/v1/auth/signup").send({
    fname: "test",
    lname: "USer",
    username: "testUser",
    password: "test123",
    image: "profile.png",
    email: "test2@gmail.com",
  });

  const res = await api.post("/api/v1/auth/login").send({
    username: "testUser",
    password: "test123",
  });
  token = res.body.token;
});




test("Game get", async () => {
    const res=await api
    .get("/api/v1/football/game")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe("Successfully fetched today's games");

});


test("Game get by date ", async () => {
    const res=await api
    .get("/api/v1/football/game/2023/2023-05-23")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched games for 2023-05-23`);

});

test("Game stats of fixture ", async () => {
    const res=await api
    .get("/api/v1/football/stats/157408")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched team statistics`);

});


test("Game team standing ", async () => {
    const res=await api
    .get("/api/v1/football/standings/teams")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched team standings`);

});

test("Game top scorers ", async () => {
    const res=await api
    .get("/api/v1/football/standings/players")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched top scorers`);

});

test("Game team goal stats ", async () => {
    const res=await api
    .get("/api/v1/football/stats/157408")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched team statistics`);

});

test("Get all players", async () => {
    const res=await api
    .get("/api/v1/football/89/players")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched players`);
});


test("Get player by id",async()=>{
    const res=await api
    .get("/api/v1/football/players/101")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.message).toBe(`Successfully fetched player`);

});

test("get league",async()=>{
    const res=await api
    .get("/api/v1/football/league")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    expect(res.body.id).toBe(98);   

})

