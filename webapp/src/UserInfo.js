import React, { useEffect, useState } from 'react'

export default function UserInfo(props) {
  const [name, setName] = useState();
  const [email, setEmail] = useState();
  const [preferred_username, setUsername] = useState();
  const [id, setId] = useState();

  useEffect(() => {
    console.log('keycloak', props.keycloak)

    props.keycloak.loadUserInfo().then(userInfo => {
      setName(userInfo.name);
      setEmail(userInfo.email);
      setUsername(userInfo.preferred_username);
      setId(userInfo.sub);
    })
  }, []);

  return (
    <div className="UserInfo">
      <p>UserName: {preferred_username}</p>
      <p>Name: {name}</p>
      <p>Email: {email}</p>
      <p>ID: {id}</p>
    </div>
  );

}
