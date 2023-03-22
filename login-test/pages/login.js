import React, { useState } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";

function LoginPage() {
  const [userStatus, setUserStatus] = useState("guest");
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const router = useRouter();

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post("http://127.0.0.1:8080/peoplecrud/Login?username=" + name + "&password=" + password);
      
      const users = response.data;
      console.log(users);
      if (users[0] == "0") {
        setError("Incorrect name or password");
        return;
      }
      localStorage.setItem("username", name);
      router.push("/mainPage");
    } catch (error) {
      console.error(error);
      setError("An error occurred while logging in");
    }
  };
  const handleUserStatusChange = (event) => {
    setUserStatus(event.target.value);
  };

  return (
    <div className="login-form">
    <h2 className="form-title">Sign-In to Your Library Account</h2>
    <hr className="form-divider" />
    <form onSubmit={handleSubmit} className="form">
      <div className="form-group">
        <label htmlFor="userStatus" className="form-label">You are a:</label>
        <select id="userStatus" value={userStatus} onChange={handleUserStatusChange} className="form-select">
          <option value="guest">Guest</option>
          <option value="admin">Admin</option>
        </select>
      </div>
      <div className="form-group">
        <label htmlFor="name" className="form-label">Username:</label>
        <input
          type="text"
          id="name"
          placeholder="Enter your Username"
          value={name}
          onChange={(event) => setName(event.target.value)}
          required
          className="form-input"
        />
      </div>
      <div className="form-group">
        <label htmlFor="password" className="form-label">Password:</label>
        <input
          type="password"
          id="password"
          placeholder="Enter your password"
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          required
          className="form-input"
        />
      </div>
      <div className="form-group">
        <Link href="/forgetpassword" className="forgetpassword">
          Forget password
        </Link>
      </div>
      <div className="form-group">
        <button type="submit" className="form-submit-btn">Submit</button>
        <button className="signup-link">
          <Link href="/signup">Sign up</Link>
        </button>
      </div>
    </form>
    {error && <div className="error">{error}</div>}
  </div>
  );
}

export default LoginPage;
