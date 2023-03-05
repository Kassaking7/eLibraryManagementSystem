import React, { useState } from "react";
import axios from "axios";
import Link from "next/link";
import { useRouter } from "next/router";

function SignupPage() {
  const [userStatus, setUserStatus] = useState("guest");
  const [name, setName] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [email, setEmail] = useState("");
  const [error, setError] = useState(null);
  const router = useRouter();

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (password !== confirmPassword) {
      setError("Passwords do not match.");
      return;
    }
    try {
      const allusers = await axios.post("http://127.0.0.1:8080/peoplecrud/listPeople");
      const usernum = allusers.data.length;
      const newusernum = usernum + 1;
      console.log(newusernum);
      const response = await axios.post("http://127.0.0.1:8080/peoplecrud/insert?id=" + newusernum + 
                                    "&username=" + name + 
                                    "&is_guest=" + true + 
                                    "&password=" + password +
                                    "&email_address=" + email);
      console.log(response.data);
      const users = response.data;
      if (users.length == 0) {
        setError("Sign Up failed");
        return;
      }
      localStorage.setItem("username", name);
      router.push("/mainPage");
    } catch (error) {
      console.error(error);
      setError("An error occurred while Signing up");
    }
  };
  const handleUserStatusChange = (event) => {
    setUserStatus(event.target.value);
  };

  return (
    <div className="login-form">
    <h2 className="form-title">Sign Up</h2>
    <hr className="form-divider" />
    <form onSubmit={handleSubmit} className="form">
      <div className="form-group">
      </div>
      <div className="form-group">
        <label htmlFor="name" className="form-label">Username:</label>
        <input
          type="text"
          id="name"
          placeholder="Enter your username"
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
          <label htmlFor="confirmPassword" className="form-label">
            Confirm Password:
          </label>
          <input
            type="password"
            id="confirmPassword"
            placeholder="Confirm your password"
            value={confirmPassword}
            onChange={(event) => setConfirmPassword(event.target.value)}
            required
            className="form-input"
          />
      </div>
      <div className="form-group">
        <label htmlFor="email_address" className="form-label">Email:</label>
        <input
          type="text"
          id="email"
          placeholder="Enter your email"
          value={email}
          onChange={(event) => setEmail(event.target.value)}
          required
          className="form-input"
        />
      </div>
      <div className="form-group">
        <button type="submit" className="form-submit-btn">Sign Up</button>
      </div>
    </form>
    {error && <div className="error">{error}</div>}
  </div>
  );
}

export default SignupPage;
