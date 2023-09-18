import React, { useState } from "react";
import axios from "axios";
import { useRouter } from "next/router";

function Forgetpassword() {
  const [userStatus, setUserStatus] = useState("guest");
  const [email, setEmail] = useState("");
  const [code, setCode] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState(null);
  const [step, setStep] = useState(1); // 1 for email/code, 2 for password

  const router = useRouter();

  const handleSubmit = async (event) => {
    event.preventDefault();
    
    if (step === 1) {
      // Handle email/code submission
      try {
        // Your code to send email/code and verify it here
        const response = await axios.post("http://127.0.0.1:8080/api/auth/start-reset?email="+email+"&code="+code,{},{withCredentials: true});
        // If verification is successful, move to step 2
        const res = response.data;
        console.log(res);
        if (res.status == 200) {
          setStep(2);
        } else {
          setError(res.message);
        }
      } catch (error) {
        console.error(error);
        setError("An error occurred while logging in");
      }
    } else if (step === 2) {
      // Handle password submission
      try {
        // Your code to reset password here
        const response = await axios.post("http://127.0.0.1:8080/api/auth/do-reset?password="+password,{},{withCredentials: true});
        const res = response.data;
        console.log(res);
        if (res.status == 200) {
          console.log("Password reset successfully.");
          localStorage.setItem("username",res.message);
          router.push("/mainPage");
        } else {
          setError(res.message);
        }
      } catch (error) {
        console.error(error);
        setError("An error occurred while resetting the password");
      }
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

      const response = await axios.post("http://127.0.0.1:8080/api/auth/valid-reset-email?email="+email,{},{withCredentials: true});  

      console.log("Verification code sent successfully.");
      console.log(response.data);
    } catch (error) {
      console.error(error);
      setError("An error occurred while obtaining the verification code");
    }
  };

  function isValidEmail(email) {
    const atSymbolCount = (email.match(/@/g) || []).length;
    return atSymbolCount === 1;
  }

  return (
    <div className="login-form">
      <h2 className="form-title">Reset Password</h2>
      <hr className="form-divider" />
      <form onSubmit={handleSubmit} className="form">
        {step === 1 && (
          <div>
            <div className="form-group">
              <label htmlFor="email" className="form-label">Email:</label>
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
              <label htmlFor="code" className="form-label">Verification Code:</label>
              <input
                type="code"
                id="code"
                placeholder="Enter your code"
                value={code}
                onChange={(event) => setCode(event.target.value)}
                required
                className="form-input"
              />
            </div>
            <div className="form-group">
              <button type="button" className="form-code-btn" onClick={handlGetCode}>Obtain Verification Code</button>
            </div>
          </div>
        )}
        {step === 2 && (
          <div>
            <div className="form-group">
              <label htmlFor="password" className="form-label">New Password:</label>
              <input
                type="password"
                id="password"
                placeholder="Enter your new password"
                value={password}
                onChange={(event) => setPassword(event.target.value)}
                required
                className="form-input"
              />
            </div>
            <div className="form-group">
              <label htmlFor="confirmPassword" className="form-label">Confirm Password:</label>
              <input
                type="password"
                id="confirmPassword"
                placeholder="Confirm your new password"
                value={confirmPassword}
                onChange={(event) => setConfirmPassword(event.target.value)}
                required
                className="form-input"
              />
            </div>
          </div>
        )}
        <div className="form-group">
          <button type="submit" className="form-submit-btn">{step === 1 ? "Submit" : "Reset Password"}</button>
        </div>
      </form>
      {error && <div className="error">{error}</div>}
    </div>
  );
}

export default Forgetpassword;
