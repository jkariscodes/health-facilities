import { useState } from "react";
import axios from "axios";
import useSWR from "swr";
import { Icon } from "leaflet";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import { Alert, Spinner } from "react-bootstrap";
import "./App.css";
import health from "./assets/health.png";


const fetcher = (url) => axios.get(url).then((res) => res.data);

export const myIcon = new Icon({
  iconUrl: health,
  iconSize: [38, 45],
  iconAnchor: [22, 94],
  shadowAnchor: [4, 62],
  popupAnchor: [-3, -76],
});

function App() {
  const [activeFacility, setActiveFacility] = useState(null);
  const position = [1.000, 38.000];
  const zoom = 6;
  const { data, error } = useSWR("http://localhost:8000/api/v1/healthfacilities", fetcher);
  const facilities = data && !error ? data : {};

  if (error) {
    return <Alert variant="danger">Ohh No! We have a problem!</Alert>;
  }
  if (!data) {
    return (
      <Spinner
        animation="border"
        variant="danger"
        role="status"
        style={{
          width: "300px",
          height: "300px",
          margin: "auto",
          display: "block",
        }}
      />
    );
  }

  return (
    <>
      <MapContainer center={position} zoom={zoom}>
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        {facilities.features.map((facility, key) => (
            <Marker
               key={key}
               position={[
                facility.geometry.coordinates[0][1],
                facility.geometry.coordinates[0][0],
               ]}
               onClick={() => {
                  setActiveFacility(facility);
               }}
               icon={myIcon}
            >
               <Popup
                  position={[
                    facility.geometry.coordinates[0][1],
                    facility.geometry.coordinates[0][0],
                  ]}
                  onClose={() => {
                     setActiveFacility(null);
                  }}
               >
                  <div>
                     <h6>{facility.properties.name}</h6>
                     <p>{facility.properties.amenity}</p>
                  </div>
               </Popup>
            </Marker>
         ))}
      </MapContainer>
    </>
  );
}

export default App;
