<?php

/**
 * @file
 * Contains \Drupal\test_api\Controller\TestAPIController.
 */

namespace Drupal\test_api\Controller;

use Drupal\Core\Controller\ControllerBase;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;


use \Drupal\node\Entity\Node;
use \Drupal\file\Entity\File;

use \Drupal\user\Entity\User;
use \Drupal\profile\Entity\Profile;

use Drupal\Core\Form\FormState;
use Drupal\Core\Entity;
use Drupal\user\Controller;

/**
 * Controller routines for test_api routes.
 */
class TestAPIController extends ControllerBase {

  public function __construct(){
     \Drupal::logger('hello world')->notice("__construct TestAPIController");
  }

  public function user_login( Request $request )
  {
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);
//      dsm($json_array['username']);
//      dsm($json_array['password']);

      // Return new user session to client.
      $uid = \Drupal::service('user.auth')->authenticate($json_array['username'], $json_array['password']);
      $session_manager = \Drupal::service('session_manager');
      $session_id = $session_manager->getId();
      $session_name = $session_manager->getName();

      $user = User::load($uid);

      $arr_user = array();
      $arr_user['name'] = $user->get('name')->getValue()[0]['value'];
      $arr_user['mail'] = $user->get('mail')->getValue()[0]['value'];

      try {
        if(!empty($user->get('user_picture')->getValue()[0]['target_id'])){
            $file = file_load($user->get('user_picture')->getValue()[0]['target_id']);
            $arr_user['url_image'] = file_create_url($file->get('uri')->getValue()[0]['value']);
        }else{
            $arr_user['url_image']="";
        }
      } catch (Exception $e) {
        \Drupal::logger('test_api')->notice($e->getMessage());
      }


      // profile

//      $query = \Drupal::entityQuery('profile')
//          ->condition('uid', $uid); /* การ query จาก entity profile โดย condition uid = 1 */
//      $nids = $query->execute();
//
//      if (count($nids) > 0){
//
//      }else{
//
//
//      }

      // profile

      return new JsonResponse( array( 'uid' => $uid, 'session_id' => $session_id, 'session_name' => $session_name,'user' => $arr_user ) );
    }
    $response['data'] = 'user login';
    $response['method'] = 'POST';

    return new JsonResponse( $response );
  }

  public function user_register( Request $request )
  {
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);
//      dsm($json_array['username']);
//      dsm($json_array['password']);

      /** @var \Drupal\user\Entity\User $user */
      $user = entity_create('user', array(
          'name' => $json_array['username'],
          'mail' => $json_array['email'],
          'pass' => $json_array['password'],
          'status' =>1,
      ));

      // Validate the object.
      $errors = $user->validate();

      if ($errors->count() > 0) {
        return new JsonResponse( array( 'error' => $errors->__toString()) );
      } else {
        // Save new user
        $user->save();
        // Return new user credentials
        return new JsonResponse( array( 'user' => $user->toArray() ) );
      }
    }
    $response['data'] = 'user login';
    $response['method'] = 'POST';
    return new JsonResponse( $response );
  }

  public function user_logout( Request $request )
  {
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);

      $result = user_logout();
      return new JsonResponse($result);
    }
    $response['data'] = 'user logout';
    $response['method'] = 'POST';

    return new JsonResponse( $response );
  }

  /**
   * Callback for `my-api/get.json` API method.
   *
   * การเรียกใช้งาน localhost/my-api/get.json?_format=json
   */
  public function get_example( Request $request ) {

    $response['data'] = 'Some test data to return';
    $response['method'] = 'GET';

//    $data = json_decode( $request->getContent(), TRUE );

    // \Drupal::logger('get_example')->notice($request->getContent());

    \Drupal::logger('get_example #1')->notice($request->getQueryString());
    // \Drupal::logger('get_example #2')->notice($output);

    return new JsonResponse( $response );
  }

  /**
   * Callback for `my-api/put.json` API method.
   */
  public function put_example( Request $request ) {

    $response['data'] = 'Some test data to return';
    $response['method'] = 'PUT';

    return new JsonResponse( $response );
  }

  /**
   * Callback for `my-api/post.json` API method.
   */
  public function post_example( Request $request ) {

    // This condition checks the `Content-type` and makes sure to 
    // decode JSON string from the request body into array.
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $data = json_decode( $request->getContent(), TRUE );
//      $request->request->replace( is_array( $data ) ? $data : [] );
//
//      $output = implode(', ', array_map(
//          function ($v, $k) {
//            if(is_array($v)){
//              return $k.'[]='.implode('&'.$k.'[]=', $v);
//            }else{
//              return $k.'='.$v;
//            }
//          },
//          $data,
//          array_keys($data)
//      ));
      // \Drupal::logger('post_example #0')->notice(serialize($data));
      // $postData = $request->getPathInfo();
      // dsm($request->getContent());


      // $jObj = json_decode($request->getContent());
      $json_array  = json_decode($request->getContent(), true);
//      dsm($json_array['username']);
//      dsm($json_array['password']);
//      dsm($json_array['data']);
      // \Drupal::logger('post_example #1 : ')->notice($request->getContent());
      // \Drupal::logger('post_example #2 : ')->notice($username);
      // \Drupal::logger('post_example #1')->notice(gettype($output));
      // \Drupal::logger('post_example #1')->notice($request);
      // \Drupal::logger('post_example #2')->notice($request->getContent());
      // \Drupal::logger('post_example #3')->notice(gettype($request->getContent()));

      //parse_str($request->getContent(), $op);
      // parse_str($output, $op2);
      // dsm($op2);
      // \Drupal::logger('post_example #4')->notice($op['username']);
      // \Drupal::logger('post_example #3')->notice($request->getQueryString());

      // return new JsonResponse( $data );
    }

    // Save Image file -------------------------------
    // $data = base64_decode("");
    // $file = file_save_data($data, 'public://users/test.png' /*public://ชื่อ folder/ชือ file */ , FILE_EXISTS_REPLACE);
    // Save Image file -------------------------------

//    $output = implode(', ', array_map(
//        function ($v, $k) {
//          if(is_array($v)){
//            return $k.'[]='.implode('&'.$k.'[]=', $v);
//          }else{
//            return $k.'='.$v;
//          }
//        },
//        $_FILES,
//        array_keys($_FILES)
//    ));
//    \Drupal::logger('post_example #0')->notice($_FILES[0]);

    // Create Node Object ----------------------------
    /*
    // Create file object from remote URL.
    $data = base64_decode("");
    $data = file_get_contents('https://www.google.co.th/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png');
    $file = file_save_data($data, 'public://users/druplicon.png', FILE_EXISTS_REPLACE);

    // Create node object with attached file.
    $node = Node::create([
        'type'        => 'article',
        'title'       => 'Druplicon test',
        'body'        => 'My Body',
        'field_image' => [
            'target_id' => $file->id(),
            'alt' => 'Hello world',
            'title' => 'Goodbye world'
        ],
    ]);
    $node->save();
    */
    // Create Node Object ----------------------------


    // Update Node Object ----------------------------
    /*
    $node = Node::load(52);
    //set value for field
    $node->type  = "article";
    $node->title = "Update Title - article";
    $node->body->value = 'My Body';
    $node->body->format = 'full_html';

    //save to update node
    $node->save();
    */
    // Update Node Object ----------------------------

    // $user = User::load(1); // 1 will be the user is , you can pass any user id

    // \Drupal::logger('post_example #xx')->notice(serialize($user)) ; // will print the user object in watchdog

    // dsm(entity_load("profile", 2));

//    $uid = 2;
//
//    // https://www.sitepoint.com/drupal-8-version-entityfieldquery/
//    $query = \Drupal::entityQuery('profile')
//        ->condition('uid', $uid); /* การ query จาก entity profile โดย condition uid = 1 */
//    $nids = $query->execute();
//
//    if (count($nids) > 0){
//
//      // dsm(entity_load("profile", reset($nids))); // reset เป้นการดึง array index 0 ออกมา
//
//      // dsm(entity_load("profile", reset($nids))->get('field_parse_id')->getValue());
//
//      // สามารถ load entity ได้ 2 แบบ
//      //  $profile = Profile::load(2);                 // แบบที่ 1
//      $profile = entity_load("profile", reset($nids));   // แบบที่ 2
//
//      // การดึงค่า
//      // dsm($profile->get('field_parse_id')->getValue());  // dsm($profile->get('field_parse_id')->getValue()[0]['value']);
//
//      /* กรณีต้องการ update ค่า
//      $profile->field_parse_id = "654321";
//      $profile->save();
//      */
//    }else{
//
//      /* กรณียังไม่ได้ สร้าง Profile ให้สร้างให้ uid */
//      $profile = Profile::create([
//          'type' => 'main',
//          'uid' => $uid,
//          'field_parse_id'=>array('value'=>'-x-'),
//      ]);
//      $profile->save();
//    }

    /*
    $uid = 1;

    $query = \Drupal::database()->select('profile', 'p');

    $query->leftJoin('profile__field_uuid_device', 'puuid', 'puuid.entity_id = p.profile_id');
    // $query->condition('n.type', 'article');
    $query->condition('p.uid', $uid);
    $query->fields('p', ['profile_id']);
    $query->fields('puuid', ['field_uuid_device_value']);
    // $query->orderBy('n.nid', 'DESC');
    // $query->condition('n.nid', 23);

    $result = $query->execute()->fetchObject();

    // dsm(property_exists($result, 'profile_id'));
    // กรณีที่ ไม่มี profile_id ก็จะไม่ error งั้นแสดงว่า user id ยังไม่มี profile
    if ($result->profile_id) {
      // กรณี user id นี้มี profile อยู่แล้ว

      // Load profile by profile_id
      $profile = entity_load("profile", $result->profile_id);

      dsm($profile);

      // การดึง ข้อมูลของแต่ field
      // $profile->get('field_parse_id')->getValue()[0]['value']

      // $result->field_parse_id;
      // $result->field_uuid_device;
      // $result->field_model_device;
      // $result->field_name_device;
      // $result->field_system_version_device;

//      if($_POST['parse_id'] != ""){
//        $parse_id = $profile->get('field_parse_id')->getValue()[0]['value'];
//
//        if ($parse_id == ""){
//          $profile->field_parse_id = $_POST['parse_id'];
//        }else if($parse_id != $_POST['parse_id']){
//
//        }
//
//        $profile->save();
//      }

    }else{

      // กรณียังไม่ได้ สร้าง Profile ให้สร้างให้ uid
      $profile = Profile::create([
          'type' => 'main',
          'uid' => $uid,
          'field_parse_id'=>array('value'=>'-x-'),
      ]);
      $profile->save();
    }

    */



    /*

    <div class="promot-banner">&nbsp;<a href="http://cdc.parliament.go.th/draftconstitution2/main.php?filename=index" target="_blank" style="line-height: 20.4px;"><img src="http://mol.go.th/sites/default/files/images/jpg/banner_cdcparliament_for09june2016_001.jpg" alt="คณะกรรมการร่างรัฐธรรมนูญ" title="คณะกรรมการร่างรัฐธรรมนูญ" width="211" height="40" /></a>&nbsp;<a href="http://www.oic.go.th/ginfo" target="_blank" style="line-height: 20.4px;"><img src="http://mol.go.th/sites/default/files/images/thumbnail/ginfo.jpg" alt="ระบบฐานข้อมูลหน่วยงานภาครัฐ" title="ระบบฐานข้อมูลหน่วยงานภาครัฐ" width="141" height="40" /></a><span style="line-height: 20.4px;">&nbsp;&nbsp;</span><a href="https://www.ega.or.th/th/index.php" target="_blank" style="line-height: 20.4px;"><img src="/sites/default/files/images/govchannel-banner-half-banner-234-60.png" alt="สำนักงานรัฐบาลอิเล็กทรอนิกส์" title="สำนักงานรัฐบาลอิเล็กทรอนิกส์" width="156" height="40" /></a><span style="line-height: 20.4px;">&nbsp;</span></div>
      */

    /*
     *

    <div class="t-header"><a href="#" target="_blank" style="line-height: 20.4px;"><img src="http://mol.go.th/sites/default/files/images/thumbnail/king70years.png" alt="ระบบฐานข้อมูลหน่วยงานภาครัฐ" title="ระบบฐานข้อมูลหน่วยงานภาครัฐ" width="100%" height="40" /> </a></div>

    $result = $query->fetchObject();
print $result->zip;
    */
//
//    $record = $result->fetchAllAssoc();
//
//    dsm($record);

//    if (count($result->fetchAll()) > 0){
//
//      // $record = $result->fetchAssoc();
//
//      while($record = $result->fetchAssoc()){
//
//        dsm($record);
//      }
//      dsm("1");
//    }else{
//      dsm("2");
//    }

    dsm("N");

    $response['data'] = 'Some test data to return';
    $response['method'] = 'POST';

    return new JsonResponse( $response );
  }

  public function list_article( Request $request ) {
    $response = array();

    /*
    $query = \Drupal::entityQuery('node')
        ->condition('status', 1)
        ->condition("type", "article");

    $query = \Drupal::database()->select('node');
    $query->condition('status', 1);
    $query->condition("type", "article");

    $nids = $query->execute();


    $nodes = entity_load_multiple('node', $nids);
//
//    $node = entity_load('node', 40);
    // // Load node
//    $node = Node::load($ticketID);

    // $nodes = Node::load($nids[1]);

    foreach ($nodes as $value) {

      // dsm($value);
      // dsm($value->get('nid')->getValue());
      // dsm($value->get('type')->getValue());
      // dsm($value->get('body')->getValue());
      // dsm($value->get('langcode')->getValue());

      // # การ get path file image
      // Refer : http://drupal.stackexchange.com/questions/105064/how-to-get-the-absolute-path-for-files-based-on-fid
      // $file = file_load(11 );
      // dsm($file->get('uri')->getValue()); // public://2016-06/generateImage_fTIMI3.jpeg
      // # Example การ ดึง URL ตัวอยา่ง เช่น http://localhost/sites/default/files/2016-06/generateImage_fTIMI3.jpeg
      // $url = file_create_url("public://2016-06/generateImage_fTIMI3.jpeg");  //
      // dsm($url);
    }

    // dsm(gettype($nodes));
    // dsm(count($nodes));
    // dsm($nodes);
    // $response['data'] = array_values($nodes);
    */


//    $query = \Drupal::database()->select('node_revision', 'nr');
//    $query->join('node', 'n', 'n.vid = nr.vid');
//    $query->leftJoin('users_field_data', 'u', 'u.uid = nr.revision_uid');
//    $query->fields('nr', ['revision_uid'])
//        ->fields('u', ['name', 'mail'])
//        ->fields('n', ['nid', 'uuid'])
//        ->condition('n.nid', 23);

    // node_field_dataHide

    $query = \Drupal::database()->select('node', 'n');
    $query->fields('n', ['nid', 'uuid']);
    $query->leftJoin('node_field_data', 'nfd', 'nfd.nid = n.nid');
    $query->condition('n.type', 'article');
    $query->condition('nfd.status', 1);
    $query->orderBy('n.nid', 'DESC');
    // $query->condition('n.nid', 23);

    $result = $query->execute();

    $count = 0;
    while($record = $result->fetchAssoc()){
      $node = entity_load('node', $record['nid']);

      // dsm($node->get('field_image')->getValue()[0]['target_id']);
      // dsm($node);


      $response['data'][$count]['nid'] = $node->get('nid')->getValue()[0]['value'];
      $response['data'][$count]['type'] = $node->get('type')->getValue()[0]['target_id'];
      $response['data'][$count]['title'] = $node->get('title')->getValue()[0]['value'];
      $response['data'][$count]['body'] = $node->get('body')->getValue()[0]['value'];

      $file = file_load($node->get('field_image')->getValue()[0]['target_id']);
      $response['data'][$count]['url_image'] = file_create_url($file->get('uri')->getValue()[0]['value']);

      $count++;
    }

    $response['result'] = true;

    return new JsonResponse( $response );
  }

  public function add_article( Request $request )
  {
    // This condition checks the `Content-type` and makes sure to
    // decode JSON string from the request body into array.
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);
//      dsm($json_array['uid']);
//      dsm($json_array['title']);
//      dsm($json_array['body']);
//      dsm($json_array['image']);

      $data = base64_decode($json_array['image']);
      $file = file_save_data($data, 'public://users/' . ini_get('date.timezome') .'_'.date('m-d-Y_hia') .'_'.rand(1, 1000)  .'.png', FILE_EXISTS_REPLACE);

      $node = Node::create([
          'uid'         => $json_array['uid'],
          'type'        => 'article',
          'title'       => $json_array['title'],
          'body'        => $json_array['body'],
          'field_image' => [
              'target_id' => $file->id(),
              'alt' => '',
              'title' => ''
          ],
      ]);
      $node->save();

      return new JsonResponse( $json_array );
    }

    $response['result'] = true;
    return new JsonResponse( $response );
  }

  // Refer : http://dropbucket.org/node/7270
  public function edit_article( Request $request )
  {
    // This condition checks the `Content-type` and makes sure to
    // decode JSON string from the request body into array.
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);
//      dsm($json_array['uid']);
//      dsm($json_array['title']);
//      dsm($json_array['body']);
//      dsm($json_array['image']);

      $data = base64_decode($json_array['image']);
      $file = file_save_data($data, 'public://users/'.date('m-d-Y_hisa') .'.png', FILE_EXISTS_REPLACE);

//      $node = Node::create([
//          'uid'         => $json_array['uid'],
//          'type'        => 'article',
//          'title'       => $json_array['title'],
//          'body'        => $json_array['body'],
//          'field_image' => [
//              'target_id' => $file->id(),
//              'alt' => '',
//              'title' => ''
//          ],
//      ]);
//      $node->save();

      $node = Node::load($json_array['nid']);
      $node->title = $json_array['title'];
      $node->body->value = $json_array['body'];
      // $node->body->format = 'full_html';
      $node->field_image = array(
          'target_id' =>  $file->id(),
          'alt' => "'",
          'title' => "'",
      );
      $node->save();
      /*
         $node = Node::load(52);
    //set value for field
    $node->type  = "article";
    $node->title = "Update Title - article";
    $node->body->value = 'My Body';
    $node->body->format = 'full_html';

    //save to update node
    $node->save();
       */
      return new JsonResponse( $json_array );
    }

    $response['result'] = true;
    return new JsonResponse( $response );
  }

  public function delete_article( Request $request )
  {
    // This condition checks the `Content-type` and makes sure to
    // decode JSON string from the request body into array.
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);

      $data = base64_decode($json_array['image']);
      $file = file_save_data($data, 'public://users/'.date('m-d-Y_hisa') .'.png', FILE_EXISTS_REPLACE);

      $node = Node::load($json_array['nid']);
      $node->status = 0;
      $node->save();

      return new JsonResponse( $json_array );
    }

    $response['result'] = true;
    return new JsonResponse( $response );

  }

  /*
       $query = \Drupal::database()->select('node', 'n');
    $query->fields('n', ['nid', 'uuid']);
    $query->leftJoin('node_field_data', 'nfd', 'nfd.nid = n.nid');
    $query->condition('n.type', 'article');
    $query->condition('nfd.status', 1);
    $query->orderBy('n.nid', 'DESC');
    // $query->condition('n.nid', 23);

   *
       $query = \Drupal::database()->select('node', 'n');
    $query->fields('n', ['nid', 'uuid']);
    $query->leftJoin('node_field_data', 'nfd', 'nfd.nid = n.nid');
    $query->condition('n.type', 'article');
    $query->condition('nfd.status', 1);
    $query->orderBy('n.nid', 'DESC');
    // $query->condition('n.nid', 23);

    $result = $query->execute();
   */
  public function device_push_notification( Request $request )
  {
    if ( 0 === strpos( $request->headers->get( 'Content-Type' ), 'application/json' ) ) {
      $json_array  = json_decode($request->getContent(), true);
//
////      $data = base64_decode($json_array['image']);
////      $file = file_save_data($data, 'public://users/'.date('m-d-Y_hisa') .'.png', FILE_EXISTS_REPLACE);
////
////      $node = Node::load($json_array['nid']);
////      $node->status = 0;
////      $node->save();
//
      $query = \Drupal::database()->select('node__field_uuid_device', 'nuuid');//('node__field_uuid_device', 'nuuid');
      $query->fields('nuuid', ['entity_id']);
      // $query->leftJoin('node__field_uuid_device', 'nuuid', 'nuuid.entity_id = n.nid');
//      // $query->fields('nuuid', ['field_uuid_device_value']);
      // $query->leftJoin('node_field_data', 'nfd', 'nfd.nid = n.nid');
      $query->condition('nuuid.field_uuid_device_value', $json_array['uuid_device']);
//
      $result = $query->execute()->fetchObject();

      // dsm(property_exists($result, 'profile_id'));
      // กรณีที่ ไม่มี entity_id ก็จะไม่ error งั้นแสดงว่า user id ยังไม่มี profile
      if ($result->entity_id) {
//        $response['value'] = $result->entity_id;
//
//        // device_push_notification
//
//        // $profile = entity_load("profile", reset($nids));   // แบบที่ 2
//////
//////      // การดึงค่า
//////      // dsm($profile->get('field_parse_id')->getValue());  // dsm($profile->get('field_parse_id')->getValue()[0]['value']);
//////
//////      /* กรณีต้องการ update ค่า
////        $profile->field_parse_id = "654321";
////        $profile->save();
//
//        $node = Node::load($result->entity_id);
//        //set value for field
//        $node->field_uuid_device->value  = "article";
////        $node->title = "Update Title - article";
////        $node->body->value = 'My Body';
////        $node->body->format = 'full_html';
////
////        //save to update node
//        $node->save();
//
        $response['node']  = $result;

      }else{
        $node = Node::create([
          'type'                    => 'device_push_notification',
          'title' => "Device Push Notification",
          'field_model_device'      => $json_array['model_device'],
          'field_name_device'       => $json_array['name_device'],
          'field_parse_id'          => $json_array['parse_id'],
          'field_system_version_device' => $json_array['system_version_device'],
          'field_uuid_device'       => $json_array['uuid_device'],
          // 'field_type_device'  // -ขาด field type device  ยังติดอยู่ยังหาวิธีการทำไม่ได้
        ]);
        $node->save();
      }

      $response['result'] = true;

      return new JsonResponse( $response );
    }

    $response['result']   = false;
    $response['message']  = "Method Not Allowed (Allow: POST)";
    return new JsonResponse( $response );
  }

  /**
   * Callback for `my-api/delete.json` API method.
   */
  public function delete_example( Request $request ) {

    $response['data'] = 'Some test data to return';
    $response['method'] = 'DELETE';

    \Drupal::logger('delete_example #1')->notice($request->getQueryString());

    return new JsonResponse( $response );
  }

}
