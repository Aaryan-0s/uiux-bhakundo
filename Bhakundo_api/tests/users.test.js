const supertest = require("supertest");

const app = require("../app");

const api = supertest(app);

const User = require("../models/user");

const mongoose = require("mongoose");
const fs = require("fs");
const img="../public/uploads/IMG-1687677731729.jpg"

beforeAll(async () => {
  await User.deleteMany({});
});
let token = "";
test("user registration", async () => {
  const res = await api
    .post("/api/v1/auth/signup")
    .send({
      fname: "test",
      lname: "USer",
      username: "testUser",
      password: "test123",
      image:"profile.png",
      email: "test2@gmail.com",
    })
    .expect(201);

  expect(res.body.user.username).toBe("testUser");
});

test("registration of duplicate username", async () => {
  const res = await api
    .post("/api/v1/auth/signup")
    .send({
      fname:"test",
      lname:"USer",
      username: "testUser",
      password: "testUser",
      fullname: "Test User 2",
      email: "test2@gmail.com",
    })
    .expect(400);
  expect(res.body.message).toMatch(/user already exist/);
});

test("registrated user can login", async () => {
  const res = await api
    .post("/api/v1/auth/login")
    .send({
      username: "testUser",
      password: "test123",
    })
    .expect(201);
    token=res.body.token

  expect(res.body.token).toBeDefined();
});

test("user login with unregistered username", async () => {
  const res = await api
    .post("/api/v1/auth/login")
    .send({
      username: "test",
      password: "test",
    })
    .expect(400);


  expect(res.body.message).toBe("user doesnt exist");
});

test("user login with wrong password", async () => {
  const res = await api
    .post("/api/v1/auth/login")
    .send({
      username: "testUser",
      password: "test",
    })
    .expect(400);

  expect(res.body.message).toBe("incorrect password");
});
test("user info by id ", async () => {
  const res = await api
    .get("/api/v1/auth/info/get")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    

  expect(res.body.data[0].username).toBe("testUser");
});

test("user can upload an image", async () => {
  const res = await api
    .post("/api/v1/auth/uploadImage")
    .set("Authorization", `Bearer ${token}`)
    .attach("profilePicture", fs.readFileSync("public/uploads/IMG-1687677731729.jpg"))
    .expect(400);

  
  expect(res.body.message).toBe("Please upload a file");
});

test("user update ", async () => {
  const res = await api

    .put("/api/v1/auth/profile/update")
    .set("Authorization", `Bearer ${token}`)
    .send({
      fname:"test1",
      lname:"USer1",
      username: "testUser1",
      password: "testUser1",
      fullname: "Test User 1",
      email: "test1@gmail.com",

})
.expect(200);
expect(res.body.message).toBe("Profile updated successfully");});



test("user delete ", async () => {
  const res = await api
    .delete("/api/v1/auth/delete")
    .set("Authorization", `Bearer ${token}`)
    .expect(200);
    

  expect(res.body.message).toBe("User deleted successfully");
});

test("user update ", async () => {
  const res = await api

    .put("/api/v1/auth/profile/update")
    .set("Authorization", `Bearer ${token}`)
    .send({
      fname:"test1",
      lname:"USer1",
      username: "testUser1",
      password: "testUser1",
      fullname: "Test User 1",
      email: "test1@gmail.com",

})
.expect(404);
expect(res.body.error).toBe("User not found");});





afterAll(async () => await mongoose.connection.close());
