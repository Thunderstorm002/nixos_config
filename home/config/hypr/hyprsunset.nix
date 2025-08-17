{
  ...
}:

{
  services.hyprsunset = {
    enable = false;
    settings = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          {
            temperature = "5700";
            gamma = "80";
          }
        ];
      };
      sunset = {
        calendar = "*-*-* 18:00:00";
        requests = [
          {
            temperature = "4000";
            gamma = "40";
          }
        ];
      };
    };
  };
}
