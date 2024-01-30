const supertest = require("supertest");

const app = require("../app");

const api = supertest(app);

const User = require("../models/user");
const Comment = require("../models/comment");

const mongoose = require("mongoose");
let token = "";
let comment_id = "";

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

test("comment post", async () => {
  let gameId = "101";
  const res = await api
    .post(`/api/v1/comment/${gameId}`)
    .set("Authorization", `Bearer ${token}`)
    .send({
      content: "test comment 1",
    })
    .expect(200);

  expect(res.body.content).toBe("test comment 1");
});

test("comment post unauthorized", async () => {
  let gameId = "101";
  const res = await api
    .post(`/api/v1/comment/${gameId}`)

    .expect(401);

  expect(res.body.error).toBe("auth token not present");
});

test("comment get", async () => {
  let gameId = "101";
  const res = await api
    .get(`/api/v1/comment/${gameId}`)
    .set("Authorization", `Bearer ${token}`)
    .send({
      content: "test comment 1",
    })
    .expect(200);
  comment_id = res.body[0]._id;
  expect(res.body[0].content).toBe("test comment 1");
  expect(res.body.length).toBe(1);
});

test("comment update", async () => {
  let gameId = "101";
  const res = await api
    .put(`/api/v1/comment/${gameId}/${comment_id}`)
    .set("Authorization", `Bearer ${token}`)
    .send({
      content: "test comment 2",
    })
    .expect(200);

  expect(res.body.content).toBe("test comment 2");
});

test("comment like", async () => {
  let gameId = "101";
  const res = await api
    .post(`/api/v1/comment/${gameId}/${comment_id}/like`)
    .set("Authorization", `Bearer ${token}`)

    .expect(200);

  expect(res.body.likeCount).toBe(1);
});

test("comment unlike", async () => {
  let gameId = "101";
  const res = await api
    .post(`/api/v1/comment/${gameId}/${comment_id}/like`)
    .set("Authorization", `Bearer ${token}`)

    .expect(200);

  expect(res.body.likeCount).toBe(0);
});

test("comment delete", async () => {
  let gameId = "101";
  const res = await api
    .delete(`/api/v1/comment/${gameId}/${comment_id}`)
    .set("Authorization", `Bearer ${token}`)

    .expect(200);

  expect(res.body.message).toBe("Comment deleted successfully");
});
