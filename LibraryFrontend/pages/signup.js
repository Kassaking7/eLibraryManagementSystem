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
  const [vcode, setVcode] = useState("");
  const router = useRouter();
  function isValidEmail(email) {
    const atSymbolCount = (email.match(/@/g) || []).length;
    return atSymbolCount === 1;
  }
  const handleSubmit = async (event) => {
    event.preventDefault();
    if (password !== confirmPassword) {
      setError("Passwords do not match.");
      return;
    }
    if (password.length < 5) {
      setError("password must be at least 7 characters.");
      return;
    }
    if (!isValidEmail(email)) {
      setError("Email should contain only 1 @");
      return;
    }
    try {
      const response = await axios.post("http://127.0.0.1:8080/api/auth/register?username=" + name + 
                                       "&password=" + password + "&email=" + email + "&code=" + vcode,{},{withCredentials: true});
      const res = response.data;
        console.log(res);
        if (res.status == 200) {
          console.log("signup successfully.");
          localStorage.setItem("username",name);
          router.push("/mainPage");
        } else {
          setError(res.message);
        }
    } catch (error) {
      console.error(error);
      setError("An error occurred while Signing up");
    }
  };
  const handleUserStatusChange = (event) => {
    setUserStatus(event.target.value);
  };

  const handlGetCode = async () => {
    try {
      if (!isValidEmail(email)) {
        setError("Email should contain only 1 @");
        return;
      }
  
      const response = await axios.post("http://127.0.0.1:8080/api/auth/valid-register-email?email="+email,{},{withCredentials: true});  
  
      console.log("Verification code sent successfully.");
      console.log(response.data);
    } catch (error) {
      console.error(error);
      setError("An error occurred while obtaining the verification code");
    }
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
      <button type="submit" className="form-code-btn" onClick={handlGetCode}>Obtain Verification Code</button>
      <div className="form-group">
        <label htmlFor="verification_code" className="form-label">Verification Code:</label>
        <input
          type="text"
          id="code"
          placeholder="Enter the verification code"
          value={vcode}
          onChange={(event) => setVcode(event.target.value)}
          required
          className="form-input"
        />
      </div>
      <div className="form-group">
      <Link href="/login" className="forgetpassword">
          Go back
        </Link>
        <button type="submit" className="form-signup-btn">Sign Up</button>
      </div>
    </form>
    {error && <div className="error">{error}</div>}
  </div>
  );
}

export default SignupPage;
