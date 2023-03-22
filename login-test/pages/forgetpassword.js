import React, { useState } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";

function Forgetpassword() {
  const [userStatus, setUserStatus] = useState("guest");
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const router = useRouter();

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post("http://127.0.0.1:8080/peoplecrud/findPeopleByNameAndPassword?name=" + name + "&password=" + password);
      
      const users = response.data;
      if (!users.length) {
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
        <label htmlFor="email" className="form-label">Email:</label>
        <input
          type="text"
          id="email"
          placeholder="Enter your email"
          value={email}
          onChange={(event) => setName(event.target.value)}
          required
          className="form-input"
        />
      </div>
      <div className="form-group">
        <label htmlFor="code" className="form-label">code:</label>
        <input
          type="code"
          id="code"
          placeholder="Enter your code"
          value={password}
          onChange={(event) => setPassword(event.target.value)}
          required
          className="form-input"
        />
      </div>
      <div className="form-group">
        <Link href="/forgetpassword" className="forgetpassword">
          Send verification code
        </Link>
      </div>
      <div className="form-group">
        <button type="submit" className="form-submit-btn">Submit</button>
      </div>
    </form>
    {error && <div className="error">{error}</div>}
  </div>
  );
}

export default Forgetpassword;
