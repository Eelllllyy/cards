export const mobileDevice = () => {
  if (/Android|webOS|iPhone|iPad|iPod/i.test(navigator.userAgent)) {
    noAccess.value = true
  }
  else{
    noAccess.value = false ;
  }
}