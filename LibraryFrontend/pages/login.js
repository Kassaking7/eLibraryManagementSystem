import React, { useState, useEffect } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";

function LoginPage() {
  const [userStatus, setUserStatus] = useState("guest");
  const [name, setName] = useState("");
  const [remember, setRemember] = useState(false);
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const router = useRouter();
  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      console.log(remember);
      const response = await axios.post("http://127.0.0.1:8080/api/auth/login?username=" + name 
                                        + "&password=" + password 
                                        + "&remember=" + remember,{},
                                        
                                        {
                                          withCredentials: true
                                      });
      
      const users = response.data;
      console.log(users);
      console.log(response)
      if (users.success == false) {
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
  useEffect(() => {
    axios.get("http://127.0.0.1:8080/api/user/me" ,{},{withCredentials: true})
    .then(response => {
      if (response.data.success == true) {
        localStorage.setItem("username", response.data.message.username);
        router.push("/mainPage");
      };
    })
    .catch(error => {
      console.log(error);
    });
  }, []);
  return (
    <div className="login-form">
    <h2 className="form-title">Sign-In to Your Library Account</h2>
    <hr className="form-divider" />
    <form onSubmit={handleSubmit} className="form">
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
      <div className="form-check">
      <div className="Remember-me">Remember Me</div>
      <input
          type="checkbox"
          id="remember"
          value={remember}
          onChange={(event) => setRemember(event.target.checked)}
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
