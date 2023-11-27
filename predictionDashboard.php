<!DOCTYPE html>
<html>

<head>
    <title>POST Body</title>
    <style>
        form {
            margin: 30px 0px;
        }

        input {
            display: block;
            margin: 10px 15px;
            padding: 8px 10px;
            font-size: 16px;
        }

        div {
            font-size: 20px;
            margin: 0px 15px;
        }

        h2 {
            color: green;
            margin: 20px 15px;
        }
    </style>
</head>

<body>
    <h2>diabetes prediction</h2>
    <form method="post">
        <!-- <input type="number" name="first" placeholder="Enter first symptom">
        <input type="number" name="second" placeholder="Enter second symptom">
        <input type="number" name="third" placeholder="Enter third symptom"> -->
        <label for="cars">enter first symptom:</label>
  <select name="first" id="cars">
    <option value="1">a cracked tooth</option>
    <option value="2">Bad breath</option>
    <option value="3">Black, white, or brown tooth stains</option>
    <option value="4">bleeding</option>
    <option value="5">Cracked or chipped teeth</option>
    <option value="6">Difficulty chewing or swallowing</option>
    <option value="7">Dramatic weight loss</option>
    <option value="8">Ear Pain</option>
    <option value="9">Grooves on your teeths surface</option>
    <option value="10">gum disease</option>
    <option value="11">Holes or pits in your teeth</option>
    <option value="12">pain</option>
    <option value="13">Pain when you bite down</option>
    <option value="14">Painful chewing</option>
    <option value="15">Red and swollen gums</option>
    <option value="16">sore throat</option>
    <option value="17">Tender or bleeding gums</option>
    <option value="18">worn-down fillings or crowns</option>
    <option value="19">Yellowish discoloration</option>
  </select>

  <label for="cars">enter second symptom:</label>
  <select name="second" id="cars">
    <option value="1">a cracked tooth</option>
    <option value="2">Bad breath</option>
    <option value="3">Black, white, or brown tooth stains</option>
    <option value="4">bleeding</option>
    <option value="5">Cracked or chipped teeth</option>
    <option value="6">Difficulty chewing or swallowing</option>
    <option value="7">Dramatic weight loss</option>
    <option value="8">Ear Pain</option>
    <option value="9">Grooves on your teeths surface</option>
    <option value="10">gum disease</option>
    <option value="11">Holes or pits in your teeth</option>
    <option value="12">pain</option>
    <option value="13">Pain when you bite down</option>
    <option value="14">Painful chewing</option>
    <option value="15">Red and swollen gums</option>
    <option value="16">sore throat</option>
    <option value="17">Tender or bleeding gums</option>
    <option value="18">worn-down fillings or crowns</option>
    <option value="19">Yellowish discoloration</option>
  </select>

  <label for="cars">enter third symptom:</label>
  <select name="third" id="cars">
    <option value="1">a cracked tooth</option>
    <option value="2">Bad breath</option>
    <option value="3">Black, white, or brown tooth stains</option>
    <option value="4">bleeding</option>
    <option value="5">Cracked or chipped teeth</option>
    <option value="6">Difficulty chewing or swallowing</option>
    <option value="7">Dramatic weight loss</option>
    <option value="8">Ear Pain</option>
    <option value="9">Grooves on your teeths surface</option>
    <option value="10">gum disease</option>
    <option value="11">Holes or pits in your teeth</option>
    <option value="12">pain</option>
    <option value="13">Pain when you bite down</option>
    <option value="14">Painful chewing</option>
    <option value="15">Red and swollen gums</option>
    <option value="16">sore throat</option>
    <option value="17">Tender or bleeding gums</option>
    <option value="18">worn-down fillings or crowns</option>
    <option value="19">Yellowish discoloration</option>
  </select>
        <input type="submit" name="submit-btn" value="submit">
    </form>
    <br>
</body>

</html>

<?php


// STEP 1: Set the API endpoint URL
$apiUrl = 'http://127.0.0.1:5022/gumDisease';

// Initiate a new cURL session/resource
$curl = curl_init();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // API endpoint URL
    

    // Check if the form values are numeric
    if (is_numeric($_POST['first']) 
    && is_numeric($_POST['second'] )
    && is_numeric($_POST['third'] )
    ) {
        // Form data
        $formData = array(
            'arg_symptomOne' => $_POST['first'],
            'arg_symptomTwo' => $_POST['second'],
            'arg_symptomThree' => $_POST['third']
            
            // Add more parameters as needed
        );
    }


// STEP 3: Set the cURL options
// CURLOPT_RETURNTRANSFER: true to return the transfer as a string of the
// return value of curl_exec() instead of outputting it directly.
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$apiUrl = $apiUrl . '?' . http_build_query($formData);
curl_setopt($curl, CURLOPT_URL, $apiUrl);

// For testing:
echo "The generated URL sent to the API is:<br>" . $apiUrl . "<br><br>";

// Make a GET request
$response = curl_exec($curl);

// Check for cURL errors
if (curl_errno($curl)) {
    $error = curl_error($curl);
    // Handle the error appropriately
    die("cURL Error: $error");
}

// Close cURL session/resource
curl_close($curl);

// Process the response
// echo "<br>The predicted output in JSON format is:<br>" . var_dump($response) . "<br><br>";

// Decode the JSON into normal text
$data = json_decode($response, true);
}
// echo "<br>The predicted output in decoded JSON format is:<br>" . var_dump($data) . "<br><br>";

// Check if the response was successful
if (isset($data['0'])) {
    // API request was successful
    // Access the data returned by the API
    echo "The predicted gum disease status is:<br>";

    // Process the data
    foreach ($data as $repository) {
        echo $repository['0'], $repository['1'], $repository['2'], "<br>";
    }
} else {
    // API request failed or returned an error
    // Handle the error appropriately
    echo "API Error: " . $data['message'];
}


?>



